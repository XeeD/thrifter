def simulate_drag_sortable(model_instance, distance, direction=nil)
  distance = distance.to_i * -1 if direction == 'nahoru'
  model_name = ActiveModel::Naming.param_key(model_instance)
  page.execute_script %{
    $.getScript("https://raw.github.com/mattheworiordan/jquery.simulate.drag-sortable.js/master/jquery.simulate.drag-sortable.js", function() {
      $("tr##{model_name}_#{model_instance.id}").simulateDragSortable({ move: #{distance.to_i}});
    });
  }
  sleep 2 # Hack to ensure ajax finishes running (tweak/remove as needed for your suite)
end