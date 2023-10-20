provider "aws" {
  region = "us-west-1"  # Change this to your preferred AWS region
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"  # Replace this with your desired AMI
  instance_type = "t2.micro"

  tags = {
    Name = "TerraformExample"
  }
}
