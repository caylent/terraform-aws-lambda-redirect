variable "function_name" {
  type        =  string
  description = "(Required) Unique name for your Lambda Function."
}

variable "redirect_to" {
  type        = string
  description = "(Required) URL the Lambda Function redirects to"
}
