output "amazing-app-elb-dns" {
  description = "DNS Name of the ELB"
  value       = "${aws_elb.glofox-elb.dns_name}"
}
