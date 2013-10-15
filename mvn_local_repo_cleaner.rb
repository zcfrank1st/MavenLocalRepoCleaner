#! /usr/bin/ruby
# author : zcfrank1st
# data : 2013.10.14

path = "/Users/zcfrank1st/.m2/repository"


def del_trash_file(path)
  inner = path
  Dir.foreach(inner) do |item|
    dir_name = item.to_s
    dir = inner + "/" + dir_name

    if !dir_name.start_with?(".")

      # 迭代
      if File.directory?(dir)
        del_trash_file(dir)
      end

      # 删除文件
      if dir_name.include?(".lastUpdated") && !File.directory?(dir)
        File.delete dir
      end

    end
  end

end

def del_empty_dir(path)
  inner = path
  Dir.foreach(path) do |i|
    dir_name = i.to_s
    dir = inner + "/" + dir_name

    if !dir_name.start_with?(".")

      if File.directory?(dir) && Dir.entries(dir).size == 2 # . / ..
        Dir.delete(dir)
      else
        if File.directory?(dir)
          del_empty_dir(dir)
        end
      end

    end

  end
end

# calling
del_trash_file(path)

6.times do
  del_empty_dir(path)
end

puts "maven repo finish cleaning!"
