class Rpn:
    def eval(self, e):
        expression = e.split(' ')
        stack = []

        for s in expression:
            if s.isdigit():
                stack.append(s)
            else:
                b = stack.pop()
                a = stack.pop()

                if s == '+':
                    res = float(a) + float(b)
                elif s == '-':
                    res = float(a) - float(b)
                elif s == '*':
                    res = float(a) * float(b)
                elif s == '/':
                    res = float(a) / float(b)

                stack.append(res)

        return stack[0]

if __name__ == "__main__":
    rpn = Rpn()
    exp = '3 4 + 5 -'
    res = rpn.eval(exp)
    print(res)



