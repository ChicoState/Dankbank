from PIL import Image
import pytesseract
import sys

filename = sys.argv[1] #argument right after *.py 
#print(filename)
print(pytesseract.image_to_string(Image.open(filename))) #get text from picture, print to console