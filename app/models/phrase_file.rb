class PhraseFile

  SOURCE_FILENAME = ENV['SOURCE_FILENAME'] || "#{Rails.root}/#{Rails.env.test? ? 'spec' : 'bin'}/phrases_source.txt"
  DELIMITER = '|'

  def random
    set_random_position
    rewind_to_start_or_delimiter
    build_phrase
  end

  def append(text)
    text_to_add = " | #{text}"
    File.open(SOURCE_FILENAME, 'a') { |f| f.write(text_to_add) }
  end

  private

  def size
    @size ||= File.size SOURCE_FILENAME
  end

  def file
    @file ||= File.new(SOURCE_FILENAME, "r")
  end

  def random_position
    rand size
  end

  def step_back(file)
    file.seek(-1, IO::SEEK_CUR)
  end

  def step_forward(file)
    file.seek(1, IO::SEEK_CUR)
  end

  def file_start_or_delimiter(file)
    return true if file.pos == 0

    char = file.readchar

    if char == DELIMITER
      return true
    end

    step_back(file)

    false
  end

  def file_end_or_delimiter(char, file)
    char == DELIMITER || file.eof?
  end

  def rewind_to_start_or_delimiter
    until file_start_or_delimiter(file) do
      step_back(file)
    end
  end

  def set_random_position
    file.seek(random_position, IO::SEEK_SET)
  end

  def build_phrase
    char = file.readchar
    buffer = char

    until file_end_or_delimiter(char, file) do
      char = file.readchar
      buffer += char
    end

    buffer.chomp(DELIMITER).strip
  end

end