def MMC (iniciar, A,B):
    x = 0
    while iniciar == 0:
        x = 0
    ma = A
    mb = B
    nSoma = 0
    while ma != mb:
        if (ma < mb):
            ma = ma + A
            nSoma += 1
        else:
            mb = mb + B
            nSoma += 1
    MMC = ma
    return nSoma, MMC

def main():
    #nA = int(input("Digite um número:"))
    #nB = int(input("Digite um número:"))
    #nSomas, memeC = MMC (nA,nB)
    nSomas, memeC = MMC (1,1,128)
    print("O numero de somas eh", nSomas)
    print("O MMC vale", memeC)

main()