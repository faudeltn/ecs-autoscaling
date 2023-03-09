resource "aws_appautoscaling_target" "this" {
  count = var.create ? 1 : 0

  resource_id        = "service/${var.cluster_name}/${var.service_name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
  min_capacity       = var.min_capacity
  max_capacity       = var.max_capacity

  lifecycle {
    ignore_changes = [min_capacity, max_capacity]
  }

}

resource "aws_appautoscaling_scheduled_action" "scale_out" {
  count = var.create ? 1 : 0

  name               = var.scale_out_action.name
  resource_id        = aws_appautoscaling_target.this[0].resource_id
  scalable_dimension = aws_appautoscaling_target.this[0].scalable_dimension
  service_namespace  = aws_appautoscaling_target.this[0].service_namespace
  schedule           = var.scale_out_action.schedule
  timezone           = var.timezone

  scalable_target_action {
    min_capacity = var.scale_out_action.min_capacity
    max_capacity = var.scale_out_action.max_capacity
  }
}

resource "aws_appautoscaling_scheduled_action" "scale_in" {
  count = var.create ? 1 : 0
    
  name               = var.scale_in_action.name
  resource_id        = aws_appautoscaling_target.this[0].resource_id
  scalable_dimension = aws_appautoscaling_target.this[0].scalable_dimension
  service_namespace  = aws_appautoscaling_target.this[0].service_namespace
  schedule           = var.scale_in_action.schedule
  timezone           = var.timezone

  scalable_target_action {
    min_capacity = var.scale_in_action.min_capacity
    max_capacity = var.scale_in_action.max_capacity
  }
}
