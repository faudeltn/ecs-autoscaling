output "scale_out_action_name" {
  value = try(aws_appautoscaling_scheduled_action.scale_out[0].name, "")
}

output "scale_in_action_name" {
  value = try(aws_appautoscaling_scheduled_action.scale_in[0].name, "")
  
}
