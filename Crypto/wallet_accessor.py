import getpass
from wallet_aescipher import AESCipher

password = getpass.getpass()

cipher = AESCipher(password)

ciphertxt = ''
with open('wallet.bin', 'r') as f:
    ciphertxt = f.read()

plaintxt = cipher.decrypt(ciphertxt)
with open('plaintext_wallet.txt', 'w') as f:
    try:
        file = f.write(plaintxt.decode('utf-8'))
    except UnicodeDecodeError:
        print('GET OUT NORMIES REEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE')
        exit(0)
print("Wallet Decrypted")
