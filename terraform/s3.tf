resource "random_id" "bucket_id" {
  byte_length = 4
}

resource "aws_s3_bucket" "fleet_frontend" {
  bucket = "${var.app_name}-bucket-${random_id.bucket_id.hex}"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_website_configuration" "fleet_frontend" { 
  # Flutter je single page app - sve rute idu na index.html (sve se učitava u browser samo jednom)
  bucket = aws_s3_bucket.fleet_frontend.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html" # Flutter router preuzima
  }
}

resource "aws_s3_bucket_public_access_block" "fleet_frontend" {
  bucket = aws_s3_bucket.fleet_frontend.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "fleet_frontend" {
  bucket = aws_s3_bucket.fleet_frontend.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = "*"
      Action    = "s3:GetObject" # ovo i ovo iznad znači da mogu svi da čitaju
      Resource  = "${aws_s3_bucket.fleet_frontend.arn}/*"
    }]
  })

  depends_on = [aws_s3_bucket_public_access_block.fleet_frontend]
}

resource "aws_cloudfront_distribution" "fleet_frontend" {
  enabled             = true
  default_root_object = "index.html"
  
  origin {
    domain_name = aws_s3_bucket_website_configuration.fleet_frontend.website_endpoint
    origin_id   = "S3-${aws_s3_bucket.fleet_frontend.bucket}"
    
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only" # Static Website Hosting kada se koristi CDN i S3 komuniciraju putem HTTP
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "S3-${aws_s3_bucket.fleet_frontend.bucket}"
    viewer_protocol_policy = "redirect-to-https" # korisnik → CloudFront ide HTTPS

    forwarded_values {
      query_string = false
      cookies { forward = "none" }
    }
  }

  custom_error_response {
    error_code         = 404
    response_code      = 200
    response_page_path = "/index.html"
  }

  restrictions {
    geo_restriction { restriction_type = "none" }
  }

  viewer_certificate {
    cloudfront_default_certificate = true # Besplatni AWS SSL cert
  }

  tags = {
    Name = "${var.app_name}-cloudfront"
  }
}