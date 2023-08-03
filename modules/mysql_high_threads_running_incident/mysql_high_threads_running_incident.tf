resource "shoreline_notebook" "mysql_high_threads_running_incident" {
  name       = "mysql_high_threads_running_incident"
  data       = file("${path.module}/data/mysql_high_threads_running_incident.json")
  depends_on = [shoreline_action.invoke_mysql_diag_query,shoreline_action.invoke_opt_queries,shoreline_action.invoke_mysql_service_control]
}

resource "shoreline_file" "mysql_diag_query" {
  name             = "mysql_diag_query"
  input_file       = "${path.module}/data/mysql_diag_query.sh"
  md5              = filemd5("${path.module}/data/mysql_diag_query.sh")
  description      = "A long-running or poorly optimized query, causing threads to stay active for longer periods of time."
  destination_path = "/agent/scripts/mysql_diag_query.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "opt_queries" {
  name             = "opt_queries"
  input_file       = "${path.module}/data/opt_queries.sh"
  md5              = filemd5("${path.module}/data/opt_queries.sh")
  description      = "Identify the queries causing the high thread count and optimize them."
  destination_path = "/agent/scripts/opt_queries.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "mysql_service_control" {
  name             = "mysql_service_control"
  input_file       = "${path.module}/data/mysql_service_control.sh"
  md5              = filemd5("${path.module}/data/mysql_service_control.sh")
  description      = "Restart the MySQL server to clear all running threads."
  destination_path = "/agent/scripts/mysql_service_control.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_mysql_diag_query" {
  name        = "invoke_mysql_diag_query"
  description = "A long-running or poorly optimized query, causing threads to stay active for longer periods of time."
  command     = "`chmod +x /agent/scripts/mysql_diag_query.sh && /agent/scripts/mysql_diag_query.sh`"
  params      = []
  file_deps   = ["mysql_diag_query"]
  enabled     = true
  depends_on  = [shoreline_file.mysql_diag_query]
}

resource "shoreline_action" "invoke_opt_queries" {
  name        = "invoke_opt_queries"
  description = "Identify the queries causing the high thread count and optimize them."
  command     = "`chmod +x /agent/scripts/opt_queries.sh && /agent/scripts/opt_queries.sh`"
  params      = ["USERNAME","PASSWORD"]
  file_deps   = ["opt_queries"]
  enabled     = true
  depends_on  = [shoreline_file.opt_queries]
}

resource "shoreline_action" "invoke_mysql_service_control" {
  name        = "invoke_mysql_service_control"
  description = "Restart the MySQL server to clear all running threads."
  command     = "`chmod +x /agent/scripts/mysql_service_control.sh && /agent/scripts/mysql_service_control.sh`"
  params      = []
  file_deps   = ["mysql_service_control"]
  enabled     = true
  depends_on  = [shoreline_file.mysql_service_control]
}

