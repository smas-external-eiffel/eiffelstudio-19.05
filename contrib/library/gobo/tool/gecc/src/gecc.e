note

	description:

		"[
			Gobo Eiffel C Compilation.
			Take advantage of multi-CPU machines to compile several C files concurrently.
		]"

	copyright: "Copyright (c) 2018, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2019-02-05 23:54:36 +0000 (Tue, 05 Feb 2019) $"
	revision: "$Revision: 102790 $"

class GECC

inherit

	GECC_VERSION

	KL_SHARED_EXCEPTIONS
	KL_SHARED_ARGUMENTS

create

	execute

feature -- Execution

	execute
			-- Start 'gecc' execution.
		local
			l_filename: STRING
			l_file: KL_TEXT_INPUT_FILE
			l_lines: DS_ARRAYED_LIST [STRING]
			l_line: STRING
			l_mutex: MUTEX
			i, nb: INTEGER
			l_thread: WORKER_THREAD
			l_thread_count: INTEGER
		do
			Arguments.set_program_name ("gecc")
			create error_handler.make_standard
			parse_arguments
			l_filename := script_filename
			create l_file.make (l_filename)
			l_file.open_read
			if l_file.is_open_read then
				create l_lines.make (50)
				from
					l_file.read_line
				until
					l_file.end_of_file
				loop
					l_line := l_file.last_string.twin
					l_line.adjust
					if not l_line.is_empty and not (l_line.starts_with ("#") and l_filename.ends_with (".sh")) then
						l_lines.force_last (l_line)
					end
					l_file.read_line
				end
				l_file.close
				if not l_lines.is_empty then
					create l_mutex.make
					l_thread_count := thread_count
					nb := l_thread_count.min (l_lines.count - 1) - 1
					if nb >= 1 then
						from
							i := 1
						until
							i > nb
						loop
							create l_thread.make (agent process_lines (l_lines, 1, l_mutex))
							l_thread.launch
								-- Sleep a little bit so that the first
								-- lines are executed in order.
							{EXECUTION_ENVIRONMENT}.sleep (1000)
							i := i + 1
						end
						process_lines (l_lines, 1, l_mutex)
						{THREAD_CONTROL}.join_all
					end
					process_lines (l_lines, 0, l_mutex)
				end
			else
				report_cannot_read_error (l_filename)
				Exceptions.die (1)
			end
		rescue
			Exceptions.die (4)
		end

feature {NONE} -- Processing

	process_lines (a_lines: DS_ARRAYED_LIST [STRING]; a_keep_count: INTEGER; a_mutex: MUTEX)
			-- Execute lines in `a_lines' (from start to end) until
			-- it contains no more than `a_keep_count' lines.
			-- Remove each line before executing it.
			-- `a_mutex' is used to get exclusive access to `a_lines' in a multi-threaded environment.
		require
			a_lines_not_void: a_lines /= Void
			no_void_line: not a_lines.has_void
			a_keep_count_not_negative: a_keep_count >= 0
			a_mutex_not_void: a_mutex /= Void
		local
			l_line: detachable STRING
			l_done: BOOLEAN
			l_command: KL_SHELL_COMMAND
		do
			from
			until
				l_done
			loop
				a_mutex.lock
				if a_lines.count <= a_keep_count then
					l_done := True
					l_line := Void
				else
					l_line := a_lines.first
					a_lines.remove_first
				end
				a_mutex.unlock
				if l_line /= Void then
					create l_command.make (l_line)
					l_command.execute
					if l_command.exit_code /= 0 then
						Exceptions.die (1)
					end
				end
			end
		end

feature -- Access

	error_handler: UT_ERROR_HANDLER
			-- Error handler

feature -- Error handling

	report_cannot_read_error (a_filename: STRING)
			-- Report that `a_filename' cannot be
			-- opened in read mode.
		require
			a_filename_not_void: a_filename /= Void
		local
			an_error: UT_CANNOT_READ_FILE_ERROR
		do
			create an_error.make (a_filename)
			error_handler.report_error (an_error)
		end

	report_version_number
			-- Report version number.
		local
			a_message: UT_VERSION_NUMBER
		do
			create a_message.make (Version_number)
			error_handler.report_info (a_message)
		end

feature -- Status report

	thread_count: INTEGER
			-- Number of threads to be used
		do
			Result := {EXECUTION_ENVIRONMENT}.available_cpu_count.as_integer_32
			if thread_option.was_found then
				Result := thread_option.parameter
				if Result <= 0 then
					Result := {EXECUTION_ENVIRONMENT}.available_cpu_count.as_integer_32 + Result
				end
			end
			if Result < 1 or not {PLATFORM}.is_thread_capable then
				Result := 1
			end
		ensure
			thread_count_not_negative: Result >= 1
		end

feature -- Argument parsing

	script_filename: STRING
			-- Name of the script file

	thread_option: AP_INTEGER_OPTION
			-- Option for '--thread=<thread_count>'

	version_flag: AP_FLAG
			-- Flag for '--version'

	parse_arguments
			-- Initialize options and parse the command line.
		local
			l_parser: AP_PARSER
			l_list: AP_ALTERNATIVE_OPTIONS_LIST
		do
			create l_parser.make
			l_parser.set_application_description ("Gobo Eiffel C Compilation, compile C code generated by gec.")
			l_parser.set_parameters_description ("script_filename")
				-- thread
			create thread_option.make_with_long_form ("thread")
			thread_option.set_description ("Number of threads to be used. Negative numbers -N mean %"number of CPUs - N%". (default: number of CPUs)")
			thread_option.set_parameter_description ("thread_count")
			if {PLATFORM}.is_thread_capable then
				l_parser.options.force_last (thread_option)
			end
				-- version
			create version_flag.make ('V', "version")
			version_flag.set_description ("Print the version number of gecc and exit.")
			create l_list.make (version_flag)
			l_parser.alternative_options_lists.force_last (l_list)
				-- Parsing.
			l_parser.parse_arguments
			if version_flag.was_found then
				report_version_number
				script_filename := ""
				Exceptions.die (0)
			elseif l_parser.parameters.count /= 1 then
				error_handler.report_info_message (l_parser.help_option.full_usage_instruction (l_parser))
				script_filename := ""
				Exceptions.die (1)
			else
				script_filename := l_parser.parameters.first
			end
		ensure
			script_filename_not_void: script_filename /= Void
			thread_option_not_void: thread_option /= Void
			version_flag_not_void: version_flag /= Void
		end

invariant

	error_handler_not_void: error_handler /= Void
	script_filename_not_void: script_filename /= Void
	thread_option_not_void: thread_option /= Void
	version_flag_not_void: version_flag /= Void

end