class RandomHelper

  def self.random_text
    @@random_text ||= YAML.load_file(File.join(Rails.root, "app", "models", "random_text.yml"))
  end

  def self.persons
    @@persons ||= random_text["persons"]
  end

  def self.contents
    @@contets ||= random_text["contents"]
  end

  def self.subjects
    @@subjects ||= random_text["subjects"]
  end
  
end
