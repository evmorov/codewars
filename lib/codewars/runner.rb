require 'codewars'

module Codewars
  class Runner
    def initialize(argv, stdin = STDIN, stdout = STDOUT, stderr = STDERR, kernel = Kernel)
      init_pry
      @argv = argv
      @stdin = stdin
      @stdout = stdout
      @stderr = stderr
      @kernel = kernel
    end

    def execute!
      exit_code = run_cli
      @kernel.exit(exit_code)
    end

    private

    def init_pry
      require 'pry'
      Pry.config.output = STDOUT # without this Pry does't work properly
    rescue LoadError
      nil
    end

    # rubocop:disable Metrics/MethodLength
    def run_cli
      exit_code = begin
        $stderr = @stderr
        $stdin = @stdin
        $stdout = @stdout

        Codewars::CLI.start(@argv)

        0
      rescue StandardError => e
        b = e.backtrace
        @stderr.puts("#{b.shift}: #{e.message} (#{e.class})")
        @stderr.puts(b.map { |s| "\tfrom #{s}" }.join("\n"))
        1
      rescue SystemExit => e
        e.status
      ensure
        $stderr = STDERR
        $stdin = STDIN
        $stdout = STDOUT
      end

      @kernel.exit(exit_code)
    end
  end
end
