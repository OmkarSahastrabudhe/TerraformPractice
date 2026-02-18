

resource "aws_s3_bucket" "my-bucket" {
    bucket = "my-work-buck-cdecb40"

    
    
  
}


resource "aws_s3_object" "mys3Obj" {
  for_each = fileset("/home/ubuntu/static-website", "**")
  bucket = aws_s3_bucket.my-bucket.bucket
  key = each.value
   source = "/home/ubuntu/static-website/${each.value}"
  


  
}

resource "aws_s3_bucket_website_configuration" "websiteconfig" {
bucket = aws_s3_bucket.my-bucket.bucket
index_document {
  suffix = "index.html"
}

error_document {
  key = "error.html"
}

  
}
output "website_url"{
    value = aws_s3_bucket_website_configuration.websiteconfig.website_endpoint
}

