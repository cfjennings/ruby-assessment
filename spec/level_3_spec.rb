describe "Level 3" do
  describe "Nested Structures" do
      let(:school) do 
        # Using let makes a value named school available in all of the tests.
        # This hash will reset at the beginning of each test.
        { 
          :name => "Happy Funtime School",
          :location => "NYC",
          :instructors => [ 
            {:name=>"Blake", :subject=>"Being Awesome" },
            {:name=>"Steven", :subject=>"Being Just 'OK'"},
            {:name=>"Jeff", :subject=>"Karaoke"}
          ],
          :students => [ 
            {:name => "Marissa", :grade => "B"},
            {:name=>"Billy", :grade => "F"},
            {:name => "Frank", :grade => "A"},
            {:name => "Sophie", :grade => "C"}
          ]
        }
      end

      it "modifies the hash" do 
      # modify school hash. Add key :founded_in with a value of 2013
      school[:founded_in] = 2013
      expect(school[:founded_in]).to eq(2013)
    end

    it "adds to a nested array" do
      # Add a student to the end of the school's students' array.
      school[:students] << {:name => "C.J.", :grade => "D"}
      expect(school[:students].count).to eq(5)
      expect(school[:students].last[:name]).to_not eq("Sophie")
    end

    it "deletes values from nested array" do
      # Delete the student named "Billy" from the hash
      school[:students].delete_if do |student|
        student[:name] == "Billy"
      end
      expect(school[:students].count).to eq(3)
      expect(school[:students].find {|student| student[:name] == 'Billy'}).to be_nil
    end

    it "modifies all values from nested array" do
      # Add a key to every student in the students array with a key of :semester and assign it the value "Summer".
      school[:students].each do |student|
        student[:semester] = "Summer"
      end
      expect(school[:students].all? {|student| student[:semester] == "Summer"}).to eq(true)
    end

    it "changes value of hash in nested array" do
      # Change Steven's subject to "Being Fantastic"
      school[:instructors].each do |instructor|
        if instructor[:name] == "Steven"
          instructor[:subject] = "Being Fantastic"
        end
      end
      expect(school[:instructors].find{|instructor| instructor[:name] == "Steven"}[:subject]).to eq "Being Fantastic"
    end

    it "changes value of hash in nested students array" do
      # Change Frank's grade from "A" to "F".
      school[:students].each do |student|
        if student[:name] == "Frank"
          student[:grade] = "F"
        end
      end
      expect(school[:students].find{|student| student[:name] == "Frank"}[:grade]).to eq "F"
    end

    it "finds student by their grade" do
      student_name = :banana# Return the name of the student with a "B".
      school[:students].each do |student|
        if student[:grade] == "B"
          student_name = student[:name]
        end
      end
      expect(student_name).to eq "Marissa"
    end

    it "finds subject by its instructor" do
      subject_name = :banana # Return the subject of the instructor "Jeff".
      school[:instructors].each do |instructor|
        if instructor[:name] == "Jeff"
          subject_name = instructor[:subject]
        end
      end
      expect(subject_name).to eq("Karaoke")
    end

    it "returns all values from all hashes, including nested ones" do
      expect(STDOUT).to receive(:puts).with("Happy Funtime School")
      expect(STDOUT).to receive(:puts).with("NYC")
      expect(STDOUT).to receive(:puts).with("Blake")
      expect(STDOUT).to receive(:puts).with("Being Awesome")
      expect(STDOUT).to receive(:puts).with("Steven")
      expect(STDOUT).to receive(:puts).with("Being Just 'OK'")
      expect(STDOUT).to receive(:puts).with("Jeff")
      expect(STDOUT).to receive(:puts).with("Karaoke")
      expect(STDOUT).to receive(:puts).with("Marissa")
      expect(STDOUT).to receive(:puts).with("B")
      expect(STDOUT).to receive(:puts).with("Billy")
      expect(STDOUT).to receive(:puts).with("F")
      expect(STDOUT).to receive(:puts).with("Frank")
      expect(STDOUT).to receive(:puts).with("A")
      expect(STDOUT).to receive(:puts).with("Sophie")
      expect(STDOUT).to receive(:puts).with("C")

      # puts all the values in the school. NOTE: If this takes too long, skip it!
      
      def get_values(hsh)
        lst = []
        hsh.each do |key, val|
          if val.instance_of?([].class)
            val.each do |elt|
              lst += get_values(elt)
            end
          else
            lst << val
          end
        end
        lst
      end

      get_values(school).each do |elt|
        puts elt
      end
    end
  end
end
