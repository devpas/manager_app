class ConvertVietnameseCharacter {
  List<int> convert(String textConvert) {
    List<int> codeArray = [];
    for (int i = 0; i < textConvert.length; i++) {
      int code = 0;
      switch (textConvert[i]) {
        case '!':
          code = 0x21;
          break;
        case '"':
          code = 0x22;
          break;
        case '#':
          code = 0x23;
          break;
        case "\$":
          code = 0x24;
          break;
        case '%':
          code = 0x25;
          break;
        case '&':
          code = 0x26;
          break;
        case '':
          code = 0x27;
          break;
        case '(':
          code = 0x28;
          break;
        case ')':
          code = 0x29;
          break;
        case '*':
          code = 0x2A;
          break;
        case '`+':
          code = 0x2B;
          break;
        case ',':
          code = 0x2C;
          break;
        case '-':
          code = 0x2D;
          break;
        case '.':
          code = 0x2E;
          break;
        case '/':
          code = 0x2F;
          break;
        case '0':
          code = 0x30;
          break;
        case '1':
          code = 0x31;
          break;
        case '2':
          code = 0x32;
          break;
        case '3':
          code = 0x33;
          break;
        case '4':
          code = 0x34;
          break;
        case '5':
          code = 0x35;
          break;
        case '6':
          code = 0x36;
          break;
        case '7':
          code = 0x37;
          break;
        case '8':
          code = 0x38;
          break;
        case '9':
          code = 0x39;
          break;
        case ':':
          code = 0x3A;
          break;
        case ';':
          code = 0x3B;
          break;
        case '<':
          code = 0x3C;
          break;
        case '+':
          code = 0x3D;
          break;
        case '>':
          code = 0x3E;
          break;
        case '?':
          code = 0x3F;
          break;
        case '@':
          code = 0x40;
          break;
        case 'A':
          code = 0x41;
          break;
        case 'B':
          code = 0x42;
          break;
        case 'C':
          code = 0x43;
          break;
        case 'D':
          code = 0x44;
          break;
        case 'E':
          code = 0x45;
          break;
        case 'F':
          code = 0x46;
          break;
        case 'G':
          code = 0x47;
          break;
        case 'H':
          code = 0x48;
          break;
        case 'I':
          code = 0x49;
          break;
        case 'J':
          code = 0x4A;
          break;
        case 'K':
          code = 0x4B;
          break;
        case 'L':
          code = 0x4C;
          break;
        case 'M':
          code = 0x4D;
          break;
        case 'N':
          code = 0x4E;
          break;
        case 'O':
          code = 0x4F;
          break;
        case 'P':
          code = 0x50;
          break;
        case 'Q':
          code = 0x51;
          break;
        case 'R':
          code = 0x52;
          break;
        case 'S':
          code = 0x53;
          break;
        case 'T':
          code = 0x54;
          break;
        case 'U':
          code = 0x55;
          break;
        case 'V':
          code = 0x56;
          break;
        case 'W':
          code = 0x57;
          break;
        case 'X':
          code = 0x58;
          break;
        case 'Y':
          code = 0x59;
          break;
        case 'Z':
          code = 0x5A;
          break;
        case '[':
          code = 0x5B;
          break;
        case ']':
          code = 0x5D;
          break;
        case '^':
          code = 0x5E;
          break;
        case '_':
          code = 0x5F;
          break;
        case '`':
          code = 0x60;
          break;
        case 'a':
          code = 0x61;
          break;
        case 'b':
          code = 0x62;
          break;
        case 'c':
          code = 0x63;
          break;
        case 'd':
          code = 0x64;
          break;
        case 'e':
          code = 0x65;
          break;
        case 'f':
          code = 0x66;
          break;
        case 'g':
          code = 0x67;
          break;
        case 'h':
          code = 0x68;
          break;
        case 'i':
          code = 0x69;
          break;
        case 'j':
          code = 0x6A;
          break;
        case 'k':
          code = 0x6B;
          break;
        case 'l':
          code = 0x6C;
          break;
        case 'm':
          code = 0x6D;
          break;
        case 'n':
          code = 0x6E;
          break;
        case 'o':
          code = 0x6F;
          break;
        case 'p':
          code = 0x70;
          break;
        case 'q':
          code = 0x71;
          break;
        case 'r':
          code = 0x72;
          break;
        case 's':
          code = 0x73;
          break;
        case 't':
          code = 0x74;
          break;
        case 'u':
          code = 0x75;
          break;
        case 'v':
          code = 0x76;
          break;
        case 'w':
          code = 0x77;
          break;
        case 'x':
          code = 0x78;
          break;
        case 'y':
          code = 0x79;
          break;
        case 'z':
          code = 0x7A;
          break;
        case '{':
          code = 0x7B;
          break;
        case '|':
          code = 0x7C;
          break;
        case '}':
          code = 0x7D;
          break;
        case '~':
          code = 0x7E;
          break;
        case 'Ỵ':
          code = 0x59;
          break;
        case 'Ỹ':
          code = 0x59;
          break;
        case 'Ỷ':
          code = 0x59;
          break;
        case 'Ỳ':
          code = 0x59;
          break;
        case 'Ý':
          code = 0x59;
          break;
        case 'Ị':
          code = 0x49;
          break;
        case 'Ĩ':
          code = 0x49;
          break;
        case 'Ỉ':
          code = 0x49;
          break;
        case 'Ì':
          code = 0x49;
          break;
        case 'Í':
          code = 0x49;
          break;
        case 'Ạ':
          code = 0x41;
          break;
        case 'Ã':
          code = 0x41;
          break;
        case 'Ả':
          code = 0x41;
          break;
        case 'À':
          code = 0x41;
          break;
        case 'Á':
          code = 0x41;
          break;
        case 'Ụ':
          code = 0x55;
          break;
        case 'Ũ':
          code = 0x55;
          break;
        case 'Ủ':
          code = 0x55;
          break;
        case 'Ù':
          code = 0x55;
          break;
        case 'Ú':
          code = 0x55;
          break;
        case 'Ự':
          code = 0xA6;
          break;
        case 'Ữ':
          code = 0xA6;
          break;
        case 'Ử':
          code = 0xA6;
          break;
        case 'Ừ':
          code = 0xA6;
          break;
        case 'Ứ':
          code = 0xA6;
          break;
        case 'Ọ':
          code = 0x4F;
          break;
        case 'Õ':
          code = 0x4F;
          break;
        case 'Ỏ':
          code = 0x4F;
          break;
        case 'Ò':
          code = 0x4F;
          break;
        case 'Ó':
          code = 0x4F;
          break;
        case 'Ợ':
          code = 0xA5;
          break;
        case 'Ỡ':
          code = 0xA5;
          break;
        case 'Ở':
          code = 0xA5;
          break;
        case 'Ờ':
          code = 0xA5;
          break;
        case 'Ớ':
          code = 0xA5;
          break;
        case 'Ộ':
          code = 0xA4;
          break;
        case 'Ỗ':
          code = 0xA4;
          break;
        case 'Ổ':
          code = 0xA4;
          break;
        case 'Ồ':
          code = 0xA4;
          break;
        case 'Ố':
          code = 0xA4;
          break;
        case 'Ẹ':
          code = 0x45;
          break;
        case 'Ẽ':
          code = 0x45;
          break;
        case 'Ẻ':
          code = 0x45;
          break;
        case 'È':
          code = 0x45;
          break;
        case 'É':
          code = 0x45;
          break;
        case 'Ệ':
          code = 0xA3;
          break;
        case 'Ễ':
          code = 0xA3;
          break;
        case 'Ể':
          code = 0xA3;
          break;
        case 'Ề':
          code = 0xA3;
          break;
        case 'Ế':
          code = 0xA3;
          break;
        case 'Ậ':
          code = 0xA2;
          break;
        case 'Ẫ':
          code = 0xA2;
          break;
        case 'Ẩ':
          code = 0xA2;
          break;
        case 'Ầ':
          code = 0xA2;
          break;
        case 'Ấ':
          code = 0xA2;
          break;
        case 'Ặ':
          code = 0xA1;
          break;
        case 'Ẵ':
          code = 0xA1;
          break;
        case 'Ẳ':
          code = 0xA1;
          break;
        case 'Ằ':
          code = 0xA1;
          break;
        case 'Ắ':
          code = 0xA1;
          break;
        case 'Ă':
          code = 0xA1;
          break;
        case 'Â':
          code = 0xA2;
          break;
        case 'Ê':
          code = 0xA3;
          break;
        case 'Ô':
          code = 0xA4;
          break;
        case 'Ơ':
          code = 0xA5;
          break;
        case 'Ư':
          code = 0xA6;
          break;
        case 'Đ':
          code = 0xA7;
          break;
        case 'ă':
          code = 0xA8;
          break;
        case 'â':
          code = 0xA9;
          break;
        case 'ê':
          code = 0xAA;
          break;
        case 'ô':
          code = 0xAB;
          break;
        case 'ơ':
          code = 0xAC;
          break;
        case 'ư':
          code = 0xAD;
          break;
        case 'đ':
          code = 0xAE;
          break;
        case 'à':
          code = 0xB5;
          break;
        case 'ả':
          code = 0xB6;
          break;
        case 'ã':
          code = 0xB7;
          break;
        case 'á':
          code = 0xB8;
          break;
        case 'ạ':
          code = 0xB9;
          break;
        case 'ằ':
          code = 0xBC;
          break;
        case 'ẳ':
          code = 0xBD;
          break;
        case 'ẵ':
          code = 0xBE;
          break;
        case 'ắ':
          code = 0xBF;
          break;
        case 'ặ':
          code = 0xC7;
          break;
        case 'ầ':
          code = 0xC6;
          break;
        case 'ẩ':
          code = 0xC7;
          break;
        case 'ẫ':
          code = 0xC8;
          break;
        case 'ấ':
          code = 0xC9;
          break;
        case 'ậ':
          code = 0xCA;
          break;
        case 'è':
          code = 0xCB;
          break;
        case 'ẻ':
          code = 0xCE;
          break;
        case 'ẽ':
          code = 0xCF;
          break;
        case 'é':
          code = 0xD0;
          break;
        case 'ẹ':
          code = 0xD1;
          break;
        case 'ề':
          code = 0xD2;
          break;
        case 'ể':
          code = 0xD3;
          break;
        case 'ễ':
          code = 0xD4;
          break;
        case 'ế':
          code = 0xD5;
          break;
        case 'ệ':
          code = 0xD6;
          break;
        case 'ì':
          code = 0xD7;
          break;
        case 'ỉ':
          code = 0xD8;
          break;
        case 'ĩ':
          code = 0xDC;
          break;
        case 'í':
          code = 0xDD;
          break;
        case 'ị':
          code = 0xDE;
          break;
        case 'ò':
          code = 0xE0;
          break;
        case 'ỏ':
          code = 0xE1;
          break;
        case 'õ':
          code = 0xE2;
          break;
        case 'ó':
          code = 0xE3;
          break;
        case 'ọ':
          code = 0xE4;
          break;
        case 'ồ':
          code = 0xE5;
          break;
        case 'ổ':
          code = 0xE6;
          break;
        case 'ỗ':
          code = 0xE7;
          break;
        case 'ố':
          code = 0xE8;
          break;
        case 'ộ':
          code = 0xE9;
          break;
        case 'ờ':
          code = 0xEA;
          break;
        case 'ở':
          code = 0xEB;
          break;
        case 'ỡ':
          code = 0xEC;
          break;
        case 'ớ':
          code = 0xED;
          break;
        case 'ợ':
          code = 0xEE;
          break;
        case 'ù':
          code = 0xEF;
          break;
        case 'ủ':
          code = 0xF1;
          break;
        case 'ũ':
          code = 0xF2;
          break;
        case 'ú':
          code = 0xF3;
          break;
        case 'ụ':
          code = 0xF4;
          break;
        case 'ừ':
          code = 0xF5;
          break;
        case 'ử':
          code = 0xF6;
          break;
        case 'ữ':
          code = 0xF7;
          break;
        case 'ứ':
          code = 0xF8;
          break;
        case 'ự':
          code = 249;
          break;
        case 'ỳ':
          code = 250;
          break;
        case 'ỷ':
          code = 251;
          break;
        case 'ỹ':
          code = 252;
          break;
        case 'ý':
          code = 253;
          break;
        case 'ỵ':
          code = 254;
          break;
        case ' ':
          code = 32;
          break;
        default:
          code = 63;
      }
      codeArray.add(code);
      if ((i + 1) % 30 == 0) {
        codeArray.add(0x0A);
      }
    }
    return codeArray;
  }
}
