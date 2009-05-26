module DBUtils

  def self.setup_db

    unless ::DB.table_exists?(:guesses)
      ::DB.create_table(:guesses) do
        primary_key :id
        varchar :name
        Number :pounds
        Number :ounces
        DateTime :birth_date
        DateTime :created_at
        Boolean :paid_up, :default => false
      end
    end
  end
  

end
