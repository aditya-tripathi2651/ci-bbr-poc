
org = "aditya"
app = "poc"

vm_name           = "vm-aditya-poc-prod"
vm_size           = "Standard_B2s"
ssh_public_key    = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE7Rxc4owDB2kR4C02JSydXniFDX91ibdH79wCecKhrB aditya@laptop"
create_public_ip  = false
allowed_ssh_cidrs = []

storage_account_name = "adityaprodstor001" # must be globally unique
sa_account_tier      = "Standard"
sa_replication_type  = "ZRS" # prod default stronger
sa_containers        = ["appdata"]
sa_ip_rules          = []
