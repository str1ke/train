class Vagon
  attr_accessor :light

  def initialize (light = nil)
    self.light = light || random_light
  end

  def random_light
    Random.rand(2) == 1
  end  
end

class Train
  attr_accessor :position

  def initialize (vagon_count = 2)
    vagon_count.times { vagons << Vagon.new }
    self.position = 0
  end

  def move_forward
    self.position = (position + 1) % vagons.size
    current_vagon
  end
  
  def move_backward
    self.position = (position - 1) % vagons.size
    current_vagon
  end

  def current_vagon
    vagons[position]
  end

  def vagons
    @vagons ||= Array.new
  end
end

def find_train_length (train)
  train_length = 1
  first_vagon_state = train.current_vagon.light
  
  loop do
    train_length.times { train.move_forward.light = !first_vagon_state }
    train_length.times { train.move_backward }

    break if train.current_vagon.light != first_vagon_state

    train_length += 1
  end

  train_length
end

print "Enter train length : "
train = Train.new gets.chomp.to_i

start_time = Time.new
train_length = find_train_length(train)
taked_time = Time.new - start_time
print "Algorithm returns  : #{train_length}, (#{taked_time} secs)\n"