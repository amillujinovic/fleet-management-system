output "ec2_public_ip"{
    description="EC2 public IP-.NET available on :5000"
    value=aws_instance.fleet_ec2.public_ip
}
/*
output "cloudfront_url"{
    description="CloudFront URL for Flutter Web"
    value="https://${aws_cloudfront_distribution.fleet_frontend.domain_name}"
}
*/
output "s3_bucket_name"{
    description="S3 bucket for Flutter file upload"
    value=aws_s3_bucket.fleet_frontend.bucket
}