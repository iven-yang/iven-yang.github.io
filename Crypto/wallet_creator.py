import getpass
from wallet_aescipher import AESCipher

password = getpass.getpass()

cipher = AESCipher(password)

plaintxt = ''
with open('plaintext_wallet_backup.txt', 'r') as f:
    plaintxt = f.read()

ciphertxt = cipher.encrypt(plaintxt)

with open('wallet.bin', 'wb') as f:
    f.write(ciphertxt)
print("Wallet Created")
