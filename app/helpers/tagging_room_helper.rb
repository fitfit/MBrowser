module TaggingRoomHelper
  def tag_boxes_for(tags)
    s=""
    unless tags.nil?
      tags.each do |t|
        s += %{<div  class="droppable ui-widget-header" id="#{t.name}">
          <div>
            <span></span>
          </div>
<br>
          <div style="text-align:center">
            <b>#{t.name}</b>

          </div>
        </div>
        <div class="clear"></div>}
      end
    else
      s += '<div><br></div>'
    end
    s.html_safe
  end
end
