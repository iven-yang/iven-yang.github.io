# pip install pycryptodome
import base64
import hashlib
from Crypto import Random
from Crypto.Cipher import AES

class AESCipher:
    def __init__( self, key, bs=16 ):
        self.key = hashlib.sha256(key.encode('utf-8')).digest()
        self.BS = bs
    
    def pad(self, s):
        return s + (self.BS - len(s) % self.BS) * chr(self.BS - len(s) % self.BS)

    def unpad(self, s):
        return s[0:-s[-1]]
    
    def encrypt( self, raw ):
        raw = self.pad(raw)
        iv = Random.new().read( AES.block_size )
        cipher = AES.new( self.key, AES.MODE_CBC, iv )
        return base64.b64encode( iv + cipher.encrypt( raw.encode('utf-8') ) )

    def decrypt( self, enc ):
        enc = base64.b64decode(enc)
        iv = enc[:16]
        cipher = AES.new(self.key, AES.MODE_CBC, iv )
        return self.unpad(cipher.decrypt( enc[16:] ))