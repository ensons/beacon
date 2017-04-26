module Beacon
  # Executes arbitrary commands by shelling out.
  class Command
    # Convenience wrapper for Command.new().call
    #
    # @example
    #   Beacon::Command.call(['whoami']) #=> "john\n"
    #
    # @return [String] The combined stdout and stderr of the command
    #
    def self.call(command)
      new(command).call
    end

    # @param command [Array<String>] The command to be run and its arguments.
    #
    # @example
    #   Beacon::Command.new(['uname', '-a'])
    #
    def initialize(command)
      @command = command
    end

    # Executes the command by shelling out.
    #
    # @example
    #   Beacon::Command.new(['whoami']).call #=> "john\n"
    #
    # @return [String] The combined stdout and stderr of the command
    #
    def call
      Log.debug { "Running command: #{command.join(' ')}" }
      output, status = Open3.capture2e(*command)

      if status.success?
        Log.debug { 'Command succeeded.' }
      else
        Log.warn { 'Command failed.' }
      end
      output
    end

    private

    attr_reader :command
  end
end
