
org = "aditya"
app = "poc"

vm_name          = "vm-aditya-poc-dev"
vm_size          = "Standard_B2s"
ssh_public_key   = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE7Rxc4owDB2kR4C02JSydXniFDX91ibdH79wCecKhrB aditya@laptop"
create_public_ip = true

# Restrict SSH to your IP(s) only
allowed_ssh_cidrs = ["111.93.146.90/32"]

# App data storage account (not the backend one)
storage_account_name = "adityadevstor001" # must be globally unique, lowercase
sa_account_tier      = "Standard"
sa_replication_type  = "LRS"
sa_containers        = ["appdata"]
sa_ip_rules          = [] # e.g., ["<your_public_ip>/32"] if you want to restrict




