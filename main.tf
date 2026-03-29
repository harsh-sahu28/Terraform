# Simple file automation with code


# block parameters { 

#	arguments

# }

resource "local_file" "main_file" {

  # arguments
  filename        = "automated-demo.txt"
  content         = "hello dosto"
  file_permission = "0664"

}
