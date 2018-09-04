module PrintQueue
  class PrintJobRule < ApplicationRecord
    # Validations.
    validate :var_combinations

      private
      def var_combinations
        if var1_type == 0 && var2_type == 1
        elsif var1_type ==1 && var2_type == 0
        elsif var1_type ==2 && var2_type == 2
        else
          errors.add(:var1_type, "Invalid combination of var types!")
        end
      end

      # Options for entries.
      def self.options_for_var_type
        [['Value'   , '0'],
        ['Variable', '1'],
        ['Rule'    , '2']]
      end
      
      def self.options_for_operator_logic
        [['AND', '&'],
        ['OR' , '|'],
        ['XOR', '^']]
      end

      def self.options_for_operator_compare
        [['>' ,'>'  ],
        ['<' ,'<'  ],
        ['>=','>=' ],
        ['<=', '<='],
        ['==','==' ],
        ['!=', '!=']]
      end

      def self.options_for_variables
        [['User', 'user'],
        ['File Type', 'file_type'],
        ['Workstation', 'workstation']]
      end

      def self.options_for_priority
        {'High': 3,
        'Medium': 2,
        'Low': 1}
      end

      def self.options_for_priority_colors
        {3 => 'bg-danger text-light',
        2 => 'bg-warning text-dark',
        1 => 'bg-info text-light'}
      end

      def self.options_for_option_flag
        [['-E: Forces encryption when connecting to the server.', '-E'],
        ['-H (server[:port]): Specifies an alternate server.', '-H'],
        ['-T (job name): Sets job name.', '-T'],
        ['-P (printer name): Sets destination printer.', '-P'],
        ['-U (username): Specifies an alternate username.', '-U'],
        ['-# (number of copies): Sets the number of copies (1-100).', '-#'],
        ['-h: Disables banner page printing.', '-h'],
        ['-l: Print file is already formatted for the destination and should be sent without filtering.', '-l'],
        ['-p: Print file should be formatted with a shaded header with the date, time, job name, and page number (only useful when printing text files).'],
        ['-r: The named print file should be deleted after printing.', '-r'],
        ['-o "option"="value": Printer specific options use: (lpoptions -P "printer" -l) to see more', '-o']]
      end
  end
end
