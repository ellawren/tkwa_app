
class PatternPdf < Prawn::Document

  	def initialize(patterns, project, view)
	    super(:page_size => "TABLOID", :page_layout => :landscape, :left_margin => 60, :right_margin => 60, :top_margin => 60, :bottom_margin => 60)
	    @patterns = patterns

	    font "Helvetica", :size => 10
		default_leading 3

	    repeat :all do
		    # header
		    stroke_axis
		    bounding_box [bounds.left, bounds.top], :width  => bounds.width do
		        text "#{project}", :align => :left, :size => 18, :color => "16a085", :style => :bold
		        text "Pattern Language", :style => :italic
		        move_down 5
		        stroke_horizontal_rule
				move_down 15
		    end

		end
	    

	    column_box([0, 600], :columns => 4, :width => 1100, :spacer => 40) do
			@patterns.each do |p|

				if cursor < 25
					move_down cursor
				end
				
		    	text "(#{cursor.round}) #{p.number}. #{p.name}", :style => :bold, :size => 12
		    	text "Issue:", :size => 9, :color => "16a085", :style => :bold
		    	pad_bottom(10) { text "#{p.issue}" }

		    	if cursor < 25
					move_down cursor
				end

		    	text "(#{cursor.round}) Solution:", :size => 9, :color => "16a085", :style => :bold
		    	pad_bottom(20) { text "#{p.solution}" }

		    end
	    end

	end

end
