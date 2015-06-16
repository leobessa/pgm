require 'open3'

# load './pgm'

describe 'pgm' do
  let(:banner) do
"""c - carga
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
s - sair"""
  end

  let(:entrada_content) do
"9 4 5 0 8
1 3 10 3 2
1 7 5 7 9
1 6 3 15 2
2 0 3 8 10
1 0 0 1 16
9 12 7 1 3"
  end

  it 'should display banner' do
    stdin_data = %w(sample_entrada s)
    expected_output =
    """Digite o nome do arquivo de entrada:
Arquivo sample_entrada.pgm carregado com sucesso.
#{banner}
Digite um comando:"""
    output, status = Open3.capture2e("./pgm", stdin_data: stdin_data.join("\n") + "\n")
    expect(output).to eq(expected_output)
  end
  
  it 'should load file' do
    stdin_data = %w(sample_entrada c sample_entrada2 t s)
    File.open("#{stdin_data[0]}.pgm",'w') { |file| file.puts '0' }
    File.open("#{stdin_data[2]}.pgm",'w') { |file| file.puts '2' }
    expected_output =
    """Digite o nome do arquivo de entrada:
Arquivo sample_entrada.pgm carregado com sucesso.
#{banner}
Digite um comando:
Digite o nome do arquivo de entrada:
Arquivo sample_entrada2.pgm carregado com sucesso.
Digite um comando:
2
Digite um comando:"""
    output, status = Open3.capture2e("./pgm", stdin_data: stdin_data.join("\n") + "\n")
    expect(output).to eq(expected_output)
  end

  it 'should display matrix' do
    input = entrada_content
    stdin_data = %w(sample_entrada t s)
    File.open("#{stdin_data[0]}.pgm",'w') do |file|
      file.puts input
    end
    expected_output =
    """Digite o nome do arquivo de entrada:
Arquivo #{stdin_data[0]}.pgm carregado com sucesso.
#{banner}
Digite um comando:
#{input}
Digite um comando:"""
    output, status = Open3.capture2e("./pgm", stdin_data: stdin_data.join("\n") + "\n")
    expect(output).to eq(expected_output)
  end
  
  it 'should display negative matrix' do
    input = "255 0\n55 200"
    stdin_data = %w(sample_entrada n t s)
    File.open("#{stdin_data[0]}.pgm",'w') do |file|
      file.puts input
    end
    expected_output =
    """Digite o nome do arquivo de entrada:
Arquivo #{stdin_data[0]}.pgm carregado com sucesso.
#{banner}
Digite um comando:
Operacao realizada com sucesso.
Digite um comando:
0 255
200 55
Digite um comando:"""
    output, status = Open3.capture2e("./pgm", stdin_data: stdin_data.join("\n") + "\n")
    expect(output).to eq(expected_output)
  end
  
  it 'should display horizontal mirrored matrix' do
    input = "1 2 3\n4 5 6\n7 8 9"
    stdin_data = %w(sample_entrada h t s)
    File.open("#{stdin_data[0]}.pgm",'w') do |file|
      file.puts input
    end
    expected_output =
    """Digite o nome do arquivo de entrada:
Arquivo #{stdin_data[0]}.pgm carregado com sucesso.
#{banner}
Digite um comando:
Operacao realizada com sucesso.
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
    stdin_data = %w(sample_entrada v t s)
    File.open("#{stdin_data[0]}.pgm",'w') do |file|
      file.puts input
    end
    expected_output =
    """Digite o nome do arquivo de entrada:
Arquivo #{stdin_data[0]}.pgm carregado com sucesso.
#{banner}
Digite um comando:
Operacao realizada com sucesso.
Digite um comando:
3 2 1
6 5 4
9 8 7
Digite um comando:"""
    output, status = Open3.capture2e("./pgm", stdin_data: stdin_data.join("\n") + "\n")
    expect(output).to eq(expected_output)
  end
  
  it 'should display rotation' do
    input = "9 4 5 0 8
1 3 10 3 2
1 7 5 7 9
1 6 3 15 2
2 0 3 8 10
1 0 0 1 16
9 12 7 1 2"
    stdin_data = %w(sample_entrada r t s)
    File.open("#{stdin_data[0]}.pgm",'w') do |file|
      file.puts input
    end
    expected_output =
    """Digite o nome do arquivo de entrada:
Arquivo #{stdin_data[0]}.pgm carregado com sucesso.
#{banner}
Digite um comando:
Operacao realizada com sucesso.
Digite um comando:
9 1 2 1 1 1 9
12 0 0 6 7 3 4
7 0 3 3 5 10 5
1 1 8 15 7 3 0
2 16 10 2 9 2 8
Digite um comando:"""
    output, status = Open3.capture2e("./pgm", stdin_data: stdin_data.join("\n") + "\n")
    expect(output).to eq(expected_output)
  end
  
  it 'should display error on cutted matrix values' do
    input = "4 5 4 4 3
4 5 4 5 4
3 4 6 6 6
2 3 6 6 8
1 1 4 6 8
4 3 3 5 6
5 4 3 4 5"
    stdin_data = %w(sample_entrada x 1 3 5 5 s)
    File.open("#{stdin_data[0]}.pgm",'w') do |file|
      file.puts input
    end
    expected_output =
    """Digite o nome do arquivo de entrada:
Arquivo #{stdin_data[0]}.pgm carregado com sucesso.
#{banner}
Digite um comando:
Limites invalidos

Digite um comando:"""
    output, status = Open3.capture2e("./pgm", stdin_data: stdin_data.join("\n") + "\n")
    expect(output).to eq(expected_output)
  end

  it 'should display cutted matrix' do
    input = "4 5 4 4 3
4 5 4 5 4
3 4 6 6 6
2 3 6 6 8
1 1 4 6 8
4 3 3 5 6
5 4 3 4 5"
    stdin_data = %w(sample_entrada x 1 3 4 4 t s)
    File.open("#{stdin_data[0]}.pgm",'w') do |file|
      file.puts input
    end
    expected_output =
    """Digite o nome do arquivo de entrada:
Arquivo #{stdin_data[0]}.pgm carregado com sucesso.
#{banner}
Digite um comando:
Operacao realizada com sucesso.
Digite um comando:
5 4
6 6
6 8
6 8
Digite um comando:"""
    output, status = Open3.capture2e("./pgm", stdin_data: stdin_data.join("\n") + "\n")
    expect(output).to eq(expected_output)
  end
  
  it 'should display erosion matrix' do
    input = "8 2 9 2 10 16 2
0 3 7 15 8 1 1
5 10 5 3 3 0 7
4 3 7 6 0 0 12
9 1 1 1 2 1 9"
    stdin_data = %w(sample_entrada e 3 t s)
    File.open("#{stdin_data[0]}.pgm",'w') { |file| file.puts input }
    expected_output =
    """Digite o nome do arquivo de entrada:
Arquivo #{stdin_data[0]}.pgm carregado com sucesso.
#{banner}
Digite um comando:
Digite o tamanho da janela:
Operacao realizada com sucesso.
Digite um comando:
0 0 2 2 1 1 1
0 0 2 2 0 0 0
0 0 3 0 0 0 0
1 1 1 0 0 0 0
1 1 1 0 0 0 0
Digite um comando:"""
    output, status = Open3.capture2e("./pgm", stdin_data: stdin_data.join("\n") + "\n")
    expect(output).to eq(expected_output)
  end
  
  it 'should display dilatacao matrix' do
    input = entrada_content
    stdin_data = %w(sample_entrada d 3 t s)
    File.open("#{stdin_data[0]}.pgm",'w') { |file| file.puts input }
    expected_output =
    """Digite o nome do arquivo de entrada:
Arquivo #{stdin_data[0]}.pgm carregado com sucesso.
#{banner}
Digite um comando:
Digite o tamanho da janela:
Operacao realizada com sucesso.
Digite um comando:
9 10 10 10 8
9 10 10 10 9
7 10 15 15 15
7 7 15 15 15
6 6 15 16 16
12 12 12 16 16
12 12 12 16 16
Digite um comando:"""
    output, status = Open3.capture2e("./pgm", stdin_data: stdin_data.join("\n") + "\n")
    expect(output).to eq(expected_output)
  end
  
  it 'should display mean matrix' do
    input = entrada_content
    stdin_data = %w(sample_entrada z 3 t s)
    File.open("#{stdin_data[0]}.pgm",'w') { |file| file.puts input }
    expected_output =
    """Digite o nome do arquivo de entrada:
Arquivo #{stdin_data[0]}.pgm carregado com sucesso.
#{banner}
Digite um comando:
Digite o tamanho da janela:
Operacao realizada com sucesso.
Digite um comando:
4 5 4 4 3
4 5 4 5 4
3 4 6 6 6
2 3 6 6 8
1 1 4 6 8
4 3 3 5 6
5 4 3 4 5
Digite um comando:"""
    output, status = Open3.capture2e("./pgm", stdin_data: stdin_data.join("\n") + "\n")
    expect(output).to eq(expected_output)
  end
  
  it 'should display median matrix' do
    input = entrada_content
    stdin_data = %w(sample_entrada m 3 t s)
    File.open("#{stdin_data[0]}.pgm",'w') { |file| file.puts input }
    expected_output =
    """Digite o nome do arquivo de entrada:
Arquivo #{stdin_data[0]}.pgm carregado com sucesso.
#{banner}
Digite um comando:
Digite o tamanho da janela:
Operacao realizada com sucesso.
Digite um comando:
4 5 4 5 3
4 5 5 5 7
3 3 6 5 7
2 3 6 7 9
1 1 3 3 10
2 2 1 3 8
9 7 1 3 3
Digite um comando:"""
    output, status = Open3.capture2e("./pgm", stdin_data: stdin_data.join("\n") + "\n")
    expect(output).to eq(expected_output)
  end
  
  it 'should display matrix with filter 1' do
    input = entrada_content
    stdin_data = %w(sample_entrada 1 3 1 t s)
    File.open("#{stdin_data[0]}.pgm",'w') { |file| file.puts input }
    expected_output =
    """Digite o nome do arquivo de entrada:
Arquivo #{stdin_data[0]}.pgm carregado com sucesso.
#{banner}
Digite um comando:
Digite o tamanho da janela:
Informe o valor de k:
Operacao realizada com sucesso.
Digite um comando:
255 255 255 255 255
255 255 255 255 255
255 255 255 255 255
255 255 255 255 255
255 255 255 255 255
255 255 255 255 255
255 255 255 255 255
Digite um comando:"""
    output, status = Open3.capture2e("./pgm", stdin_data: stdin_data.join("\n") + "\n")
    expect(output).to eq(expected_output)
  end
  
  it 'should display matrix with filter 2' do
    input = entrada_content
    stdin_data = %w(sample_entrada 2 3 1 t s)
    File.open("#{stdin_data[0]}.pgm",'w') { |file| file.puts input }
    expected_output =
    """Digite o nome do arquivo de entrada:
Arquivo #{stdin_data[0]}.pgm carregado com sucesso.
#{banner}
Digite um comando:
Digite o tamanho da janela:
Informe o valor de k:
Operacao realizada com sucesso.
Digite um comando:
255 255 255 0 255
0 255 255 255 255
0 255 255 255 255
255 255 255 255 0
255 0 255 255 255
255 0 0 255 255
255 255 255 255 255
Digite um comando:"""
    output, status = Open3.capture2e("./pgm", stdin_data: stdin_data.join("\n") + "\n")
    expect(output).to eq(expected_output)
  end
  
end