class Array

	#not very general, but works on the school object
	#assumes the array contains hashes only
	#finds and returns the hash where the given key matches the requested value
	def where(key, val)
		found = nil
		self.each do |elt|
			if elt.has_key?(key) and elt[key] == val
				found = elt
			end
		end
		found
	end
end

# returns given student's grade
def grade_for(name, hsh)
	hsh[:students].where(:name, name)[:grade]
end

#returns instructor hash based on the given name
def find_instructor(name, hsh)
	hsh[:instructors].where(:name, name)
end

#pretty repetitive. probably should combine with find_instructor. use method missing maybe?
def find_student(name, hsh)
	hsh[:students].where(:name, name)
end

# updates an instructor's subject
def update_subject_for(name, new_subj, hsh)
	instructor = find_instructor(name, hsh)
	instructor[:subject] = new_subj
end

def add_student(name, grade, hsh)
	hsh[:students] << {:name => name, :grade => grade}
end

def add_new_property(key, val, hsh)
	hsh[key] = val
end