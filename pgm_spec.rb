require 'open3'

# load './pgm'

describe 'pgm' do
  it 'should display banner' do
    stdin_data = %w(sample_entrada s)
    expected_output =
    """Digite o nome do arquivo de entrada:
Arquivo sample_entrada.pgm carregado com sucesso.
c - carga
t - exibicao na tela
n - negativo
r - rotacao
v - espelhamento vertical
h - espelhamento horizontal
x - corte
e - filtro da erosao
d - filtro da dilatacao
m - filtro da mediana
z - filtro da media
1 - filtro de bordas 1
2 - filtro de bordas 2
3 - filtro de bordas 3
g - gravacao
C - comparacao
a - ajuda
s - sair
Digite um comando:"""
    output, status = Open3.capture2e("./pgm", stdin_data: stdin_data.join("\n") + "\n")
    expect(output).to eq(expected_output)
  end

  it 'should display matrix' do
    input = """9 4 5 0 8
1 3 10 3 2
1 7 5 7 9
1 6 3 15 2
2 0 3 8 10
1 0 0 1 16
9 12 7 1 3"""
    stdin_data = %w(sample_entrada t s)
    File.open("#{stdin_data[0]}.pgm",'w') do |file|
      file.puts input
    end
    expected_output =
    """Digite o nome do arquivo de entrada:
Arquivo #{stdin_data[0]}.pgm carregado com sucesso.
c - carga
t - exibicao na tela
n - negativo
r - rotacao
v - espelhamento vertical
h - espelhamento horizontal
x - corte
e - filtro da erosao
d - filtro da dilatacao
m - filtro da mediana
z - filtro da media
1 - filtro de bordas 1
2 - filtro de bordas 2
3 - filtro de bordas 3
g - gravacao
C - comparacao
a - ajuda
s - sair
Digite um comando:
#{input}
Digite um comando:"""
    output, status = Open3.capture2e("./pgm", stdin_data: stdin_data.join("\n") + "\n")
    expect(output).to eq(expected_output)
  end
  
  it 'should display negative matrix' do
    input = "255 0\n55 200"
    stdin_data = %w(sample_entrada n s)
    File.open("#{stdin_data[0]}.pgm",'w') do |file|
      file.puts input
    end
    expected_output =
    """Digite o nome do arquivo de entrada:
Arquivo #{stdin_data[0]}.pgm carregado com sucesso.
c - carga
t - exibicao na tela
n - negativo
r - rotacao
v - espelhamento vertical
h - espelhamento horizontal
x - corte
e - filtro da erosao
d - filtro da dilatacao
m - filtro da mediana
z - filtro da media
1 - filtro de bordas 1
2 - filtro de bordas 2
3 - filtro de bordas 3
g - gravacao
C - comparacao
a - ajuda
s - sair
Digite um comando:
0 255
200 55
Digite um comando:"""
    output, status = Open3.capture2e("./pgm", stdin_data: stdin_data.join("\n") + "\n")
    expect(output).to eq(expected_output)
  end
  
  it 'should display horizontal mirrored matrix' do
    input = "1 2 3\n4 5 6\n7 8 9"
    stdin_data = %w(sample_entrada h s)
    File.open("#{stdin_data[0]}.pgm",'w') do |file|
      file.puts input
    end
    expected_output =
    """Digite o nome do arquivo de entrada:
Arquivo #{stdin_data[0]}.pgm carregado com sucesso.
c - carga
t - exibicao na tela
n - negativo
r - rotacao
v - espelhamento vertical
h - espelhamento horizontal
x - corte
e - filtro da erosao
d - filtro da dilatacao
m - filtro da mediana
z - filtro da media
1 - filtro de bordas 1
2 - filtro de bordas 2
3 - filtro de bordas 3
g - gravacao
C - comparacao
a - ajuda
s - sair
Digite um comando:
7 8 9
4 5 6
1 2 3
Digite um comando:"""
    output, status = Open3.capture2e("./pgm", stdin_data: stdin_data.join("\n") + "\n")
    expect(output).to eq(expected_output)
  end
  
  it 'should display vertical mirrored matrix' do
    input = "1 2 3
4 5 6
7 8 9"
    stdin_data = %w(sample_entrada v s)
    File.open("#{stdin_data[0]}.pgm",'w') do |file|
      file.puts input
    end
    expected_output =
    """Digite o nome do arquivo de entrada:
Arquivo #{stdin_data[0]}.pgm carregado com sucesso.
c - carga
t - exibicao na tela
n - negativo
r - rotacao
v - espelhamento vertical
h - espelhamento horizontal
x - corte
e - filtro da erosao
d - filtro da dilatacao
m - filtro da mediana
z - filtro da media
1 - filtro de bordas 1
2 - filtro de bordas 2
3 - filtro de bordas 3
g - gravacao
C - comparacao
a - ajuda
s - sair
Digite um comando:
3 2 1
6 5 4
9 8 7
Digite um comando:"""
    output, status = Open3.capture2e("./pgm", stdin_data: stdin_data.join("\n") + "\n")
    expect(output).to eq(expected_output)
  end
  
end