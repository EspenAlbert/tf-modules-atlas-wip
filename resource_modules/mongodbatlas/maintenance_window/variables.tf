variable "auto_defer" {
  type     = bool
  nullable = true
  default  = null
}

variable "auto_defer_once_enabled" {
  type     = bool
  nullable = true
  default  = null
}

variable "day_of_week" {
  type     = number
  nullable = true
  default  = null
}

variable "defer" {
  type     = bool
  nullable = true
  default  = null
}

variable "hour_of_day" {
  type     = number
  nullable = true
  default  = null
}

variable "project_id" {
  type     = string
  nullable = true
  default  = null
}

variable "start_asap" {
  type     = bool
  nullable = true
  default  = null
}

variable "protected_hours" {
  type = list(object({
    end_hour_of_day   = number
    start_hour_of_day = number
  }))
  nullable = true
  default  = null
}
