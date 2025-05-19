import re

def parse_polynomial(poly_str):
    """
    پارس کردن چندجمله‌ای مانند x^4 + x + 1
    و استخراج توان‌ها در یک لیست مرتب‌شده نزولی
    """
    terms = re.findall(r'x\^(\d+)|x|1', poly_str.replace(' ', ''))
    degrees = set()

    for term in terms:
        if term[0]:
            degrees.add(int(term[0]))
        elif term[1]:
            degrees.add(1)
        elif term[2]:
            degrees.add(0)

    if not degrees:
        raise ValueError("چندجمله‌ای معتبر وارد نشده است.")
    
    return sorted(degrees, reverse=True)

def generate_crc_verilog(degrees, module_name="crc"):
    width = max(degrees)
    taps = [0] * width
    for deg in degrees[1:]:  # درجه اول را حذف می‌کنیم چون خودش DFF است
        taps[width - deg - 1] = 1

    lines = []
    lines.append(f"module {module_name} (")
    lines.append("    input clk,")
    lines.append("    input data_in,")
    lines.append(f"    output [{width - 1}:0] crc_out")
    lines.append(");")
    lines.append("")

    # تعریف سیم‌ها و رجیسترها
    for i in range(width):
        lines.append(f"    reg d{i};")

    lines.append("")

    # اتصال‌ها
    lines.append("    always @(posedge clk) begin")
    for i in range(width - 1, 0, -1):
        xor_logic = f"d{i-1} ^ data_in" if taps[i] else f"d{i-1}"
        lines.append(f"        d{i} <= {xor_logic};")
    lines.append(f"        d0 <= data_in;")
    lines.append("    end\n")

    lines.append(f"    assign crc_out = {{ {', '.join([f'd{i}' for i in range(width - 1, -1, -1)])} }};")
    lines.append(f"endmodule")

    return "\n".join(lines)

def write_to_file(filename, content):
    with open(filename, "w") as f:
        f.write(content)

def main():
    poly_str = input("چندجمله‌ای CRC را وارد کنید (مثلاً: x^4 + x + 1):\n> ")
    try:
        degrees = parse_polynomial(poly_str)
        print(f"درجه‌ها: {degrees}")
        verilog_code = generate_crc_verilog(degrees)
        write_to_file("crc.v", verilog_code)
        print("فایل crc.v با موفقیت تولید شد.")
    except ValueError as e:
        print(f"خطا: {e}")

if __name__ == "__main__":
    main()
