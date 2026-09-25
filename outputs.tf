



output "web_server_url" {
  value       = "http://${module.compute.public_ip}"
  description = "Public URL for the deployed web server"
}