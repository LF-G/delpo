# encoding: UTF-8
class Moedor
  attr_accessor :contextos, :contextos_final, :palavras, :color, :taq2

  DEBUG = 1
  # construtor recebe o arquivo da obra e a data. Separa em contextos a obra
  def initialize(arq, data)
    @ano_dado = data
    @ano = trataData(data)
    textoaux = ""
    File.readlines(arq).each do |tex|
      tex = tex.force_encoding('UTF-8')
      textoaux = textoaux + tex.gsub("\n", "") + " "
    end
    textoaux.gsub!(/\[\[(.*?)\]\]/, '\1')
    textoaux.gsub!(/\{(.*?)\}/, '\1')
    textoaux.gsub!(/\#(.*?)\#/, '\1')
    textoaux.gsub!(/\[\.\]/, '⁙')

    texto = textoaux.gsub(/(.*?)/, '<i>\1</i>')
    texto.gsub!(/(.*?)/, '<strike>\1</strike>')
    texto.gsub!(/([[:alpha:]*]+)_([[:alpha:]*]+)/, '\1\2')
    texto.gsub!(/([[:alpha:]*]+)=+([[:alpha:]*]+)/, '\1 \2')
    @contextos = texto.scan(/[.!?⁙]?[^.!?⁙]*[.!?⁙]*/).map(&:strip)

    texto = textoaux.gsub(/(.*?)/, '')
    texto.gsub!(/(.*?)/, '\1')
    texto.gsub!(/([[:alpha:]*]+)_([[:alpha:]*]+)/, '\1 \2')
    texto.gsub!(/([[:alpha:]*]+)=+([[:alpha:]*]+)/, '\1\2')
    @contextos_final = texto.scan(/[.!?⁙]?[^.!?⁙]*[.!?⁙]*/).map(&:strip)
  end

  # mtodo que executa um comando sql no banco de dados.
  def execute_statement(sql)
    results = ActiveRecord::Base.connection.execute(sql)
    if results.present?
      return results
    else
      return nil
    end
  end

  # Ajusta o lema da palavra
  def acertaLema(palavra)
    if palavra.match(/^(d[ií])$/)
      palavra = "dir"
    elsif palavra.match(/^(tr[aá]|tr[aá]r)$/)
      palavra = "trazer"
    elsif match = palavra.match(/^(.*?)(p[oô]|p[oô]r)$/)
      s1, s2 = match.captures
      palavra = s1+"por"
    elsif match = palavra.match(/^(.*?)(f[aá]|far)$/)
      s1, s2 = match.captures
      palavra = s1+"fazer"
    elsif match = palavra.match(/^(.*?)(qu[ií]|quir)$/)
      s1, s2 = match.captures
      palavra = s1+"querer"
    elsif palavra.match(/[aá]$/)
      palavra.gsub!(/[aá]$/, "")
      palavra = palavra << "ar"
    elsif palavra.match(/[eê]$/)
      palavra.gsub!(/[eê]$/, "")
      palavra = palavra << "er"
    elsif palavra.match(/[ií]$/)
      palavra.gsub!(/[ií]$/, "")
      palavra = palavra << "ir"
    elsif palavra.match(/[oô]$/)
      palavra.gsub!(/[oô]$/, "")
      palavra = palavra << "or"
    end
    return palavra
  end

  # procura no banco a data mais antiga encontrada para a palavra
  def BD_TAQ(palavra)
    sql = "SELECT MIN(texto_data) AS minimo FROM variantes, "
    sql = sql + "ocorrencias,contextos,obras,metalemas, acepcoes, "
    sql = sql + "flexoes WHERE metalema='" + palavra + "' AND "
    sql = sql + "metalema_id = metalemas.id AND "
    sql = sql + "ocorrencias.id = ocorrenciataq_id AND "
    sql = sql + "contextos.id = contexto_id AND "
    sql = sql + "acepcoes.id = acepcao_id AND "
    sql = sql + "flexoes.id = flexao_id AND "
    sql = sql + "variantes.id = variante_id AND "
    sql = sql + "obras.id = contextos.obra_id;"
    records = execute_statement(sql)
    if !records.nil?
      return records[0]["minimo"]
    else
      return nil
    end
  end

  # Compara as datas d1 e d2 e retorna 1 caso d1 < d2 ou 0 em caso contrario
  def comparaData(d1, d2)
    count = 0;
    arr_d1 = d1.split("-")
    arr_d2 = d2.split("-")
    arr_d1.each do

      if arr_d1[count] > arr_d2[count]
        return 0
      end
      if arr_d1[count] < arr_d2[count]
        return 1
      end
      count += 1
    end
    return 0
  end

  # inicializa uma hash com as classes do sistema
  def cria_classes()
    c = Hash.new()
    c['Retrodatou'] = ["Retrodatou","FF6060","Possível retrodatação desta palavra", 1,  1]
    c['RetrodatouHomonimia'] = ["Retrodatou","FF6060","Possível retrodatação desta palavra (homonímia)", 1, 2]
    c['RetrodatouNomeProprio'] = ["Retrodatou","FF6060","Possível nome próprio", 1, 3]
    c['RetrodatouNomeProprioFlexao'] = ["Retrodatou","FF6060","Flexão ou possível nome próprio", 1, 4]
    c['RetrodatouFlex'] = ["Retrodatou","FF6060","Flexão ou possível retrodatação desta palavra", 1, 5]
    c['RetrodatouNomeProprioHomonimia'] = ["Retrodatou","FF6060","Possível nome próprio (homonímia)", 1, 6]
    c['Homo'] = ["Retrodatou","FF6060","Retrodatação improvável desta palavra", 1, 7]
    c['HomoNomeProprio'] = ["Retrodatou","FF6060","Retrodatação improvável deste nome próprio", 1, 8]
    c['SemData'] = ["SemData","80EEFF","Possível primeira datação desta palavra", 3, 9]
    c['SemDataNomeProprio'] = ["SemData","80EEFF","Possível nome próprio sem data", 3, 10]
    c['SemDataFlex'] = ["SemData","80EEFF","Flexão ou possível primeira datação desta palavra", 3, 11]
    c['SemDataNomeProprioFlexao'] = ["SemData","80EEFF", "Flexão ou possível nome próprio", 3, 12]
    c['Inexistente'] = ["Inexistente","80EEFF","Palavra não reconhecida", 3, 13]
    c['InexistenteNomeProprio'] = ["Inexistente","80EEFF","Possível nome próprio", 3, 14]
    c['InexistenteComposto'] = ["Inexistente","80EEFF","Possível composição", 3, 15]
    c['InexistenteAdverbioModo'] = ["Inexistente","80EEFF","Possível advérbio de modo", 3, 16]
    c['InexistenteDiminutivo'] = ["Inexistente","80EEFF","Possível diminutivo", 3, 17]
    c['InexistenteAumentativo'] = ["Inexistente","80EEFF","Possível aumentativo", 3, 18]
    c['InexistenteSuperlativo'] = ["Inexistente","80EEFF","Possível superlativo", 3, 19]
    c['InexistenteAbreviatura'] = ["Inexistente","80EEFF","Possível abreviatura", 3, 20]
    c['PossivelHomonimia'] = ["Inexistente","80EEFF","Possível homonímia", 3, 21]
    return c
  end

  # le um arquivo de texto onde as linhas tem um formato:
  # palavra1 palavra2
  # e cria uma hash com chave = palavra1, valor = palavra2
  def le_arquivoH (arq)
    h = Hash.new()
    text = File.open(arq).read
    text.gsub!(/\r\n?/, "\n")
    text.each_line do |line|
      s1, s2 = line.split(" ")
      h[s1] = s2
    end
    return h
  end

  # le um arquivo de texto onde cada linha  uma palavra
  # e retorna uma lista com as palavras do arquivo
  def le_arquivoL (arq)
    l = Array.new
    text = File.open(arq).read
    text.gsub!(/\r\n?/, "\n")
    text.each_line do |line|
      l = l << line
    end
    return l
  end

  # recebe uma string no tipo algarismo romano (ate XXI) representando o
  # seculo e retorna o ultimo ano daquele seculo
  def trataNumeral (n)
    answer = 0;
    match = n.match(/(X{0,3})(IV|IX|VI{0,3}|I{0,3})/)
    s1, s2 = match.captures
    answer = 10 * s1.length
    if s2 == "IV"
      answer = answer + 4
    elsif s2 == "V"
       answer = answer + 5
    elsif s2 == "VI"
      answer = answer + 6
    elsif s2 == "VII"
      answer = answer + 7
    elsif s2 == "VIII"
      answer = answer + 8
    elsif s2 == "IX"
      answer = answer + 9
    else
      answer = answer + s2.length
    end
    return answer * 100
  end

  # retorna o ultimo dia do mes, considerando tambem anos bissextos.
  def ultimoDia (mes, ano=7)
    fim_do_mes = { "1" => "31", "01" => "31", "2" => "28", "02" => "28", "3" => "31",
    "03" => "31", "4" => "30", "04" => "30", "5" => "31", "05" => "31",
    "6" => "30", "06" => "30", "7" => "31", "07" => "31", "8" => "31",
    "08" => "31", "9" => "30", "09" => "30", "10" => "31", "11" => "30",
    "12" => "31" }

    ultimo_dia = fim_do_mes[mes]

    # anos bissextos
    if ultimo_dia == "28" && ((ano % 4 == 0 && ano % 100 != 0) || ano % 400 == 0)
      ultimo_dia = ultimo_dia + 1
    end

    return ano + "-" + mes +  "-" + ultimo_dia
  end

  # recebe uma string de data e retorna para data no tipo aaaa-mm-dd
  def trataData (dat)
    # remove o c da incerteza
    dat.gsub!(/c/, '')
    #data completa
    if match = dat.match(/(\d+)\D(\d+)\D(\d+)/)
      s1, s2, s3 = match.captures
      return s3 + "-" + s2 + "-" + s1
    elsif match = dat.match(/^(\d{1,2})\/(\d+)/)
      # sem dia, 05/1811, por exemplo
      s1, s2 = match.captures
      return ultimoDia(s1.to_i, s2.to_i)
    elsif match = dat.match(/\d+\D(\d+)/)
      #2000-2001, por exemplo
      s1 = match.captures
      return s1 + "-12-31"
    #XV-XVII por exemplo
    elsif match = dat.match(/(X{0,3}(IV|IX|IV|V|I{0,3}))-(X{0,3}(IV|IX|IV|V|I{0,3}))/)
      s1, s2, s3 = match.captures
      ans = trataNumeral(s1) > trataNumeral(s3) ? trataNumeral(s1) : trataNumeral(s3)
      return ans + "-01-01"
    #2000 por exemplo
    elsif match = dat.match(/[0-9]{1,4}/)
      return dat + "-12-31"
    #XVII, por exemplo
    else
      return trataNumeral(dat).to_s + "-01-01" #1200-01-01 é o último dia do século XII
    end
  end

  # procura no banco de dados as flexoes diferentes para o termo
  def check_flexoes(termo)
    sql = "SELECT metalema FROM metalemas, acepcoes,flexoes,variantes "
    sql = sql + "WHERE flexoes.id=flexao_id AND acepcoes.id = acepcao_id "
    sql = sql + "AND metalemas.id = metalema_id AND variante='" + termo + "';"
    records = execute_statement(sql)
    if !records.nil?
      return records
    else
      return nil
    end
  end

  # Realiza o processo de moagem
  def processa_contextos

    if DEBUG == 1
      debug_file = File.new("debug/"+Time.now.to_s, "w")
      debug_file.puts "Iniciando log"
      debug_file.puts ""
    end

    # inicializacao das variaveis de classe
    @classes = cria_classes()
    @color = Hash.new("vazio")
    @taq2 = Hash.new("vazio")
    @conte = Hash.new("vazio")
    @homo = le_arquivoH('homonimos.txt')
    @abrevi = le_arquivoH('abreviaturas.txt')
    @alg = le_arquivoL('algarismos.txt')
    @antropo = le_arquivoH('antroponimos.txt')
    @topo = le_arquivoH('toponimos.txt')
    @palavras = Hash.new("vazio")

    # inicia a moagem para cada contexto
    @contextos_final.each_with_index do |cont, id|
      palavras = cont.scan(/[[:alpha:]~*+-]+ | .*?/).map(&:strip)
      i = 0

      #analiza cada palavra no contexto
      while i < palavras.length do
        palavra = palavras[i]
        # p i, palavra
        if palavra.kind_of?(Array)
          palavra = palavra[0]
        end
        if palavra.nil?
          i += 1
          next
        end
        if palavra !~ /\d/
          palavra.gsub!(/[-+]$/, '')
          palavra.gsub!(/^\'|\'$/, '')
        end
        # limpa e padroniza as palavras
        save = palavra
        ucterm = palavra
        palavra = palavra.downcase


        # analisa enclise, proclise e mesoclise
        if palavra =~ /[-]/
          if DEBUG == 1
            debug_file.puts palavra + " matched  /[-]/"
          end
          if match = palavra.match(/(\w+)-(se)-([mt]e|lhes?|[nv]os)$/)
            if DEBUG == 1
              debug_file.puts palavra + " matched  /(\w+)-(se)-([mt]e|lhes?|[nv]os)$/"
              debug_file.puts "palavra: " + palavra + ", save: " + save
            end
            s1, s2, s3 = match.captures
            palavra.gsub!(/(\w+)-(se)-([mt]e|lhes?|[nv]os)$/, s1)
            palavras = palavras << s2 << s3
            save = palavra
            palavra = acertaLema(palavra)
            if DEBUG == 1
              debug_file.puts "palavra after acertaLema: " + palavra + ", save: " + save
            end
          elsif match = palavra.match(/(\w+)-(lhe)-(l[oa]s?)$/)
            if DEBUG == 1
              debug_file.puts palavra + " matched  /(\w+)-(lhe)-(l[oa]s?)$/"
              debug_file.puts "palavra: " + palavra + ", save: " + save
            end
            s1, s2, s3 = match.captures
            palavra.gsub!(/(\w+)-(lhe)-(l[oa]s?)$/, s1)
            palavras = palavras << s2 << s3
            save = palavra
            palavra = acertaLema(palavra)
            if DEBUG == 1
              debug_file.puts "palavra after acertaLema: " + palavra + ", save: " + save
            end
          elsif match = palavra.match(/(\w+)l-([oa]s?)$/)
            if DEBUG == 1
              debug_file.puts palavra + " matched  /(\w+)l-([oa]s?)$/"
              debug_file.puts "palavra: " + palavra + ", save: " + save
            end
            s1, s2, s3 = match.captures
            palavra.gsub!(/(\w+)l-([oa]s?)$/, s1)
            palavras = palavras << s2 << s3
            save = palavra
            palavra = acertaLema(palavra)
            if DEBUG == 1
              debug_file.puts "palavra after acertaLema: " + palavra + ", save: " + save
            end
          elsif match = palavra.match(/(\w*?mo)-(l[oa]s?|nos?)$/)
            if DEBUG == 1
              debug_file.puts palavra + " matched  /(\w*?mo)-(l[oa]s?|nos?)$/"
              debug_file.puts "palavra: " + palavra + ", save: " + save
            end
            s1, s2 = match.captures
            palavra.gsub!(/(\w*?mo)-(l[oa]s?|nos?)$/, s1)
            palavras = palavras << s2
            save = s1
            if DEBUG == 1
              debug_file.puts "palavra after: " + palavra + ", save: " + save
            end
      	  elsif match = palavra.match(/(\w*?mo)-no-(l[oa]s?)$/)
            if DEBUG == 1
              debug_file.puts palavra + " matched  /(\w*?mo)-no-(l[oa]s?)$/"
              debug_file.puts "palavra: " + palavra + ", save: " + save
            end
            s1, s2 = match.captures
            palavra.gsub!(/(\w*?mo)-no-(l[oa]s?)$/, s1)
            palavras = palavras << s2
            save = s1
            if DEBUG == 1
              debug_file.puts "palavra after: " + palavra + ", save: " + save
            end
      	  elsif match = palavra.match(/(\w+?)-([nv][oa])-(l[oa]s?)$/)
            if DEBUG == 1
              debug_file.puts palavra + " matched  /(\w+?)-([nv][oa])-(l[oa]s?)$/"
              debug_file.puts "palavra: " + palavra + ", save: " + save
            end
            s1, s2, s3 = match.captures
            palavra.gsub!(/(\w+?)-([nv][oa])-(l[oa]s?)$/, s1)
            palavras = palavras << s2 << s3
            save = s1
            if DEBUG == 1
              debug_file.puts "palavra after: " + palavra + ", save: " + save
            end
          elsif match = palavra.match(/(\w*?pu)-(l.{1,2})$/)
            if DEBUG == 1
              debug_file.puts palavra + " matched  /(\w*?pu)-(l.{1,2})$/"
              debug_file.puts "palavra: " + palavra + ", save: " + save
            end
            s1, s2 = match.captures
            palavra.gsub!(/(\w*?pu)-(l.{1,2})$/, s1+"s")
            palavras = palavras << s2
            save = s1
            if DEBUG == 1
              debug_file.puts "palavra after: " + palavra + ", save: " + save
            end
          elsif match = palavra.match(/(\w*?fi)-(l.{1,2})$/)
            if DEBUG == 1
              debug_file.puts palavra + " matched  /(\w*?fi)-(l.{1,2})$/"
              debug_file.puts "palavra: " + palavra + ", save: " + save
            end
            s1, s2 = match.captures
            palavra.gsub!(/(\w*?fi)-(l.{1,2})$/, s1+"z")
            palavras = palavras << s2
            save = s1
            if DEBUG == 1
              debug_file.puts "palavra after: " + palavra + ", save: " + save
            end
          elsif match = palavra.match(/(\w*?f)ê-(l.{1,2})$/)
            if DEBUG == 1
              debug_file.puts palavra + " matched  /(\w*?f)ê-(l.{1,2})$/"
              debug_file.puts "palavra: " + palavra + ", save: " + save
            end
            s1, s2 = match.captures
            palavra.gsub!(/(\w*?f)ê-(l.{1,2})$/, s1+"ez")
            palavras = palavras << s2
            save = s1+"ê"
            if DEBUG == 1
              debug_file.puts "palavra after: " + palavra + ", save: " + save
            end
          elsif match = palavra.match(/(\w*?f)á-(l.{1,2})$/)
            if DEBUG == 1
              debug_file.puts palavra + " matched  /(\w*?f)á-(l.{1,2})$/"
              debug_file.puts "palavra: " + palavra + ", save: " + save
            end
            s1, s2 = match.captures
            palavra.gsub!(/(\w*?f)á-(l.{1,2})$/, s1+"az")
            palavras = palavras << s2
            save = s1+"á"
            if DEBUG == 1
              debug_file.puts "palavra after: " + palavra + ", save: " + save
            end
          elsif match = palavra.match(/(\w*?tr)([áa])-(l[oa]s?)$/)
            if DEBUG == 1
              debug_file.puts palavra + " matched  /(\w*?tr)([áa])-(l[oa]s?)$/"
              debug_file.puts "palavra: " + palavra + ", save: " + save
            end
            s1, s2, s3 = match.captures
            palavra.gsub!(/(\w*?tr)([áa])-(l[oa]s?)$/, s1+"az")
            palavras = palavras << s3
            save = s1+s2
            if DEBUG == 1
              debug_file.puts "palavra after: " + palavra + ", save: " + save
            end
          elsif match = palavra.match(/(\w*?)ê-(l[oa]s?)$/)
            if DEBUG == 1
              debug_file.puts palavra + " matched  /(\w*?)ê-(l[oa]s?)$/"
              debug_file.puts "palavra: " + palavra + ", save: " + save
            end
            s1, s2 = match.captures
            palavra.gsub!(/(\w*?)ê-(l[oa]s?)$/, s1+"er")
            palavras = palavras << s2
            save = s1+"ê"
            if DEBUG == 1
              debug_file.puts "palavra after: " + palavra + ", save: " + save
            end
          elsif match = palavra.match(/(\w*?e)-(l[oa]s?)$/)
            if DEBUG == 1
              debug_file.puts palavra + " matched  /(\w*?e)-(l[oa]s?)$/"
              debug_file.puts "palavra: " + palavra + ", save: " + save
            end
            s1, s2 = match.captures
            palavra.gsub!(/(\w*?e)-(l[oa]s?)$/, s1+"s")
            palavras = palavras << s2
            save = s1
            if DEBUG == 1
              debug_file.puts "palavra after: " + palavra + ", save: " + save
            end
          elsif match = palavra.match(/(\w*?ai)-(l[oa]s?)$/)
            if DEBUG == 1
              debug_file.puts palavra + " matched  /(\w*?ai)-(l[oa]s?)$/"
              debug_file.puts "palavra: " + palavra + ", save: " + save
            end
            s1, s2 = match.captures
            palavra.gsub!(/(\w*?ai)-(l[oa]s?)$/, s1+"s")
            palavras = palavras << s2
            save = s1
            if DEBUG == 1
              debug_file.puts "palavra after: " + palavra + ", save: " + save
            end
          elsif match = palavra.match(/(\w*?ei)-(l[oa]s?)$/)
            if DEBUG == 1
              debug_file.puts palavra + " matched  /(\w*?ei)-(l[oa]s?)$/"
              debug_file.puts "palavra: " + palavra + ", save: " + save
            end
            s1, s2 = match.captures
            palavra.gsub!(/(\w*?ei)-(l[oa]s?)$/, s1+"s")
            palavras = palavras << s2
            save = s1
            if DEBUG == 1
              debug_file.puts "palavra after: " + palavra + ", save: " + save
            end
          elsif match = palavra.match(/(\w*?i)-(l[oa]s?)$/)
            if DEBUG == 1
              debug_file.puts palavra + " matched  /(\w*?i)-(l[oa]s?)$/"
              debug_file.puts "palavra: " + palavra + ", save: " + save
            end
            s1, s2 = match.captures
            palavra.gsub!(/(\w*?i)-(l[oa]s?)$/, s1+"r")
            palavras = palavras << s2
            save = s1
            if DEBUG == 1
              debug_file.puts "palavra after: " + palavra + ", save: " + save
            end
          elsif match = palavra.match(/(\w*?)ô-(l[oa]s?)$/)
            if DEBUG == 1
              debug_file.puts palavra + " matched  /(\w*?)ô-(l[oa]s?)$/"
              debug_file.puts "palavra: " + palavra + ", save: " + save
            end
            s1, s2 = match.captures
            palavra.gsub!(/(\w*?)ô-(l[oa]s?)$/, s1+"or")
            palavras = palavras << s2
            save = s1+"ô"
            if DEBUG == 1
              debug_file.puts "palavra after: " + palavra + ", save: " + save
            end
          elsif match = palavra.match(/(\w*?)([áa])-(l[oa]s?)$/)
            if DEBUG == 1
              debug_file.puts palavra + " matched  /(\w*?)([áa])-(l[oa]s?)$/"
              debug_file.puts "palavra: " + palavra + ", save: " + save
            end
            s1, s2, s3 = match.captures
            palavra.gsub!(/(\w*?)([áa])-(l[oa]s?)$/, s1+"a")
            palavras = palavras << s3
            save = s1+s2
            if DEBUG == 1
              debug_file.puts "palavra after: " + palavra + ", save: " + save
            end
          elsif match = palavra.match(/-(l[oa]s?)$/)
            if DEBUG == 1
              debug_file.puts palavra + " matched  /-(l[oa]s?)$/"
              debug_file.puts "palavra: " + palavra + ", save: " + save
            end
            s1 = match.captures
            palavra.gsub!(/-(l[oa]s?)$/, "")
            palavras = palavras << s1
            save = palavra
            if DEBUG == 1
              debug_file.puts "palavra after: " + palavra + ", save: " + save
            end
          elsif match = palavra.match(/-(lhes?|[mt]e|[mtnv]?[oa]s?)$/)
            if DEBUG == 1
              debug_file.puts palavra + " matched  /-(lhes?|[mt]e|[mtnv]?[oa]s?)$/"
              debug_file.puts "palavra: " + palavra + ", save: " + save
            end
            s1 = match.captures
            palavra.gsub!(/-(lhes?|[mt]e|[mtnv]?[oa]s?)$/, "")
            palavras = palavras << s1
            save = palavra
            if DEBUG == 1
              debug_file.puts "palavra after: " + palavra + ", save: " + save
            end
          elsif match = palavra.match(/-(lh[oa]s?)$/)
            if DEBUG == 1
              debug_file.puts palavra + " matched  /-(lh[oa]s?)$/"
              debug_file.puts "palavra: " + palavra + ", save: " + save
            end
            s1 = match.captures
            palavra.gsub!(/-(lh[oa]s?)$/, "")
            palavras = palavras << s1
            save = palavra
            if DEBUG == 1
              debug_file.puts "palavra after: " + palavra + ", save: " + save
            end
          elsif match = palavra.match(/-se$/)
            if DEBUG == 1
              debug_file.puts palavra + " matched  /-se$/"
              debug_file.puts "palavra: " + palavra + ", save: " + save
            end
            palavra.gsub!(/-se$/, "")
            palavras = palavras << " se"
            save = palavra
            if DEBUG == 1
              debug_file.puts "palavra after: " + palavra + ", save: " + save
            end
          elsif match = palavra.match(/^(\w+?)-((?:[nv][oa]-l[oa]s?)|(?:se-(?:[mt]e|lhes?|[nv]os))|(?:lhe-l[oa]s?))-(ei|ás?|emos|eis|ão|ias?|íamos|íeis|iam)$/)
            if DEBUG == 1
              debug_file.puts palavra + " matched  /^(\w+?)-((?:[nv][oa]-l[oa]s?)|(?:se-(?:[mt]e|lhes?|[nv]os))|(?:lhe-l[oa]s?))-(ei|ás?|emos|eis|ão|ias?|íamos|íeis|iam)$/"
              debug_file.puts "palavra: " + palavra + ", save: " + save
            end
            s = match.captures
            palavra.gsub!(/^(\w+?)-((?:[nv][oa]-l[oa]s?)|(?:se-(?:[mt]e|lhes?|[nv]os))|(?:lhe-l[oa]s?))-(ei|ás?|emos|eis|ão|ias?|íamos|íeis|iam)$/, s[1])
            save = s[1]+"..."+s[3]
            a, b = s[2].split("-")
            palavras = palavras << a << b
      		  palavra = acertaLema(palavra)
            if DEBUG == 1
              debug_file.puts "palavra after acertaLema: " + palavra + ", save: " + save
            end
      	  elsif match = palavra.match(/^(\w+?)-([mts]e|[oa]s?|lh?[eoa]s?|[nvmt][oa]s?)-(ei|ás?|emos|eis|ão|ias?|íamos|íeis|iam)$/)
            if DEBUG == 1
              debug_file.puts palavra + " matched  /^(\w+?)-([mts]e|[oa]s?|lh?[eoa]s?|[nvmt][oa]s?)-(ei|ás?|emos|eis|ão|ias?|íamos|íeis|iam)$/"
              debug_file.puts "palavra: " + palavra + ", save: " + save
            end
            s = match.captures
            palavra.gsub!(/^(\w+?)-([mts]e|[oa]s?|lh?[eoa]s?|[nvmt][oa]s?)-(ei|ás?|emos|eis|ão|ias?|íamos|íeis|iam)$/, s[1])
            save = s[1]+"..."+s[3]
            palavras = palavras << s[2]
      		  palavra = acertaLema(palavra)
            if DEBUG == 1
              debug_file.puts "palavra after acertaLema: " + palavra + ", save: " + save
            end
          end
        end

        if match = palavra.match(/(\w+)[+](\w+)[+](\w+)[+](\w+)$/)
          if DEBUG == 1
            debug_file.puts palavra + " matched  /(\w+)[+](\w+)[+](\w+)[+](\w+)$/"
            debug_file.puts "palavra: " + palavra + ", save: " + save
          end
          s1, s2, s3, s4 = match.captures
          palavra.gsub!(/(\w+)[+](\w+)[+](\w+)[+](\w+)$/, s1+"..."+s4)
      	  palavras = palavras << s2 << s3
      	  save = s1+"..."+s4
      	  palavra = acertaLema(s1)
          if DEBUG == 1
            debug_file.puts "palavra after acertaLema: " + palavra + ", save: " + save
          end
      	elsif match = palavra.match(/(\w+)[+](\w+)[+](\w+)$/)
          if DEBUG == 1
            debug_file.puts palavra + " matched  /(\w+)[+](\w+)[+](\w+)$/"
            debug_file.puts "palavra: " + palavra + ", save: " + save
          end
          s1, s2, s3 = match.captures
          palavra.gsub!(/(\w+)[+](\w+)[+](\w+)$/, s1+"..."+s3)
      	  palavras = palavras << s2
      	  save = s1+"..."+s4
      	  palavra = acertaLema(s1)
          if DEBUG == 1
            debug_file.puts "palavra after acertaLema: " + palavra + ", save: " + save
          end
        end

        # Ajusta o verbo em caso de proclise, enclise ou mesoclise
        if palavra == "dir"
          palavra = "dizer"
        elsif palavra == "quir"
          palavra = "querer"
        elsif palavra == "far"
          palavra = "fazer"
        elsif palavra == "trar"
          palavra = "trazer"
        elsif palavra == "por"
          palavra = "pôr"
    	  elsif palavra == "hão-de" || palavra == "hei-de" || palavra == "há-de"
          palavra = "haver"
        end

        # Analisa superlativos, diminitivos e aumentativos
        palavra.gsub!(/íssim[ao]s$/, "íssimo")

        if match = palavra.match(/(.+)ã[oe]zinh([ao])s$/)
          if DEBUG == 1
            debug_file.puts palavra + " matched  /(.+)ã[oe]zinh([ao])s$/"
            debug_file.puts "palavra: " + palavra + ", save: " + save
          end
          s1, s2 = match.captures
          palavra = s1+"ãozinh"+s2
          if DEBUG == 1
            debug_file.puts "palavra after: " + palavra + ", save: " + save
          end
        end
        if match = palavra.match(/(.+)õezinh([ao])s$/)
          if DEBUG == 1
            debug_file.puts palavra + " matched  /(.+)õezinh([ao])s$/"
            debug_file.puts "palavra: " + palavra + ", save: " + save
          end
          s1, s2 = match.captures
          palavra = s1+"ãozinh"+s2
          if DEBUG == 1
            debug_file.puts "palavra after: " + palavra + ", save: " + save
          end
        end
        if match = palavra.match(/(.+[qg]uizinh[ao])s$/)
          if DEBUG == 1
            debug_file.puts palavra + " matched  /(.+[qg]uizinh[ao])s$/"
            debug_file.puts "palavra: " + palavra + ", save: " + save
          end
          s1 = match.captures
          palavra = s1
          if DEBUG == 1
            debug_file.puts "palavra after: " + palavra + ", save: " + save
          end
        end
        if match = palavra.match(/(.+[aeou])izinh([ao])s$/)
          if DEBUG == 1
            debug_file.puts palavra + " matched  /(.+[aeou])izinh([ao])s$/"
            debug_file.puts "palavra: " + palavra + ", save: " + save
          end
          s1, s2 = match.captures
          palavra = s1+"lzinh"+s2
          if DEBUG == 1
            debug_file.puts "palavra after: " + palavra + ", save: " + save
          end
        end
        if match = palavra.match(/(.+)re*zinh([ao])s$/)
          if DEBUG == 1
            debug_file.puts palavra + " matched  /(.+)re*zinh([ao])s$/"
            debug_file.puts "palavra: " + palavra + ", save: " + save
          end
          s1, s2 = match.captures
          palavra = s1+"rzinh"+s2
          if DEBUG == 1
            debug_file.puts "palavra after: " + palavra + ", save: " + save
          end
        end
        if match = palavra.match(/(.+[sz])ezinh([ao])s$/)
          if DEBUG == 1
            debug_file.puts palavra + " matched  /(.+[sz])ezinh([ao])s$/"
            debug_file.puts "palavra: " + palavra + ", save: " + save
          end
          s1, s2 = match.captures
          palavra = s1+"inh"+s2
          if DEBUG == 1
            debug_file.puts "palavra after: " + palavra + ", save: " + save
          end
        end

        palavra.gsub!(/zinhos$/, "zinho")

        if match = palavra.match(/(.+)ã[oe]zonas$/)
          if DEBUG == 1
            debug_file.puts palavra + " matched  /(.+)ã[oe]zonas$/"
            debug_file.puts "palavra: " + palavra + ", save: " + save
          end
          s1 = match.captures
          palavra = s1+"ãozona"
          if DEBUG == 1
            debug_file.puts "palavra after: " + palavra + ", save: " + save
          end
        end
        if match = palavra.match(/(.+)õezonas$/)
          if DEBUG == 1
            debug_file.puts palavra + " matched  /(.+)õezonas$/"
            debug_file.puts "palavra: " + palavra + ", save: " + save
          end
          s1 = match.captures
          palavra = s1+"ãozona"
          if DEBUG == 1
            debug_file.puts "palavra after: " + palavra + ", save: " + save
          end
        end
        if match = palavra.match(/(.+)ã[oe]zões$/)
          if DEBUG == 1
            debug_file.puts palavra + " matched  /(.+)ã[oe]zões$/"
            debug_file.puts "palavra: " + palavra + ", save: " + save
          end
          s1 = match.captures
          palavra = s1+"ãozão"
          if DEBUG == 1
            debug_file.puts "palavra after: " + palavra + ", save: " + save
          end
        end
        if match = palavra.match(/(.+)õezões$/)
          if DEBUG == 1
            debug_file.puts palavra + " matched  /(.+)õezões$/"
            debug_file.puts "palavra: " + palavra + ", save: " + save
          end
          s1 = match.captures
          palavra = s1+"ãozão"
          if DEBUG == 1
            debug_file.puts "palavra after: " + palavra + ", save: " + save
          end
        end
        if match = palavra.match(/(.+)ã[oe]zãos$/)
          if DEBUG == 1
            debug_file.puts palavra + " matched  /(.+)ã[oe]zãos$/"
            debug_file.puts "palavra: " + palavra + ", save: " + save
          end
          s1 = match.captures
          palavra = s1+"ãozão"
          if DEBUG == 1
            debug_file.puts "palavra after: " + palavra + ", save: " + save
          end
        end
        if match = palavra.match(/(.+)õezãos$/)
          if DEBUG == 1
            debug_file.puts palavra + " matched  /(.+)õezãos$/"
            debug_file.puts "palavra: " + palavra + ", save: " + save
          end
          s1 = match.captures
          palavra = s1+"ãozão"
          if DEBUG == 1
            debug_file.puts "palavra after: " + palavra + ", save: " + save
          end
        end
        if match = palavra.match(/(.+[aeou])izões$/)
          if DEBUG == 1
            debug_file.puts palavra + " matched  /(.+[aeou])izões$/"
            debug_file.puts "palavra: " + palavra + ", save: " + save
          end
          s1 = match.captures
          palavra = s1+"lzão"
          if DEBUG == 1
            debug_file.puts "palavra after: " + palavra + ", save: " + save
          end
        end
        if match = palavra.match(/(.+[aeou])izãos$/)
          if DEBUG == 1
            debug_file.puts palavra + " matched  /(.+[aeou])izãos$/"
            debug_file.puts "palavra: " + palavra + ", save: " + save
          end
          s1 = match.captures
          palavra = s1+"lzão"
          if DEBUG == 1
            debug_file.puts "palavra after: " + palavra + ", save: " + save
          end
        end
        if match = palavra.match(/(.+[aeou])izonas$/)
          if DEBUG == 1
            debug_file.puts palavra + " matched  /(.+[aeou])izonas$/"
            debug_file.puts "palavra: " + palavra + ", save: " + save
          end
          s1 = match.captures
          palavra = s1+"lzona"
          if DEBUG == 1
            debug_file.puts "palavra after: " + palavra + ", save: " + save
          end
        end
        if match = palavra.match(/(.+)rzões$/)
          if DEBUG == 1
            debug_file.puts palavra + " matched  /(.+)rzões$/"
            debug_file.puts "palavra: " + palavra + ", save: " + save
          end
          s1 = match.captures
          palavra = s1+"rzão"
          if DEBUG == 1
            debug_file.puts "palavra after: " + palavra + ", save: " + save
          end
        end
        if match = palavra.match(/(.+)rzãos$/)
          if DEBUG == 1
            debug_file.puts palavra + " matched  /(.+)rzãos$/"
            debug_file.puts "palavra: " + palavra + ", save: " + save
          end
          s1 = match.captures
          palavra = s1+"rzão"
          if DEBUG == 1
            debug_file.puts "palavra after: " + palavra + ", save: " + save
          end
        end
        if match = palavra.match(/(.+)re*zonas$/)
          if DEBUG == 1
            debug_file.puts palavra + " matched  /(.+)re*zonas$/"
            debug_file.puts "palavra: " + palavra + ", save: " + save
          end
          s1 = match.captures
          palavra = s1+"rzona"
          if DEBUG == 1
            debug_file.puts "palavra after: " + palavra + ", save: " + save
          end
        end
        if match = palavra.match(/(.+[sz])ezões$/)
          if DEBUG == 1
            debug_file.puts palavra + " matched  /(.+[sz])ezões$/"
            debug_file.puts "palavra: " + palavra + ", save: " + save
          end
          s1 = match.captures
          palavra = s1+"zão"
          if DEBUG == 1
            debug_file.puts "palavra after: " + palavra + ", save: " + save
          end
        end
        if match = palavra.match(/(.+[sz])ezãos$/)
          if DEBUG == 1
            debug_file.puts palavra + " matched  /(.+[sz])ezãos$/"
            debug_file.puts "palavra: " + palavra + ", save: " + save
          end
          s1 = match.captures
          palavra = s1+"zão"
          if DEBUG == 1
            debug_file.puts "palavra after: " + palavra + ", save: " + save
          end
        end
        if match = palavra.match(/(.+[sz])ezonas$/)
          if DEBUG == 1
            debug_file.puts palavra + " matched  /(.+[sz])ezonas$/"
            debug_file.puts "palavra: " + palavra + ", save: " + save
          end
          s1 = match.captures
          palavra = s1+"zona"
          if DEBUG == 1
            debug_file.puts "palavra after: " + palavra + ", save: " + save
          end
        end

        palavra.gsub!(/zões$|zãos/, "zão")

        # Analisa palavras compostas
        if palavra.match(/[-]/)
          if DEBUG == 1
            debug_file.puts palavra + " matched  /[-]/ composta"
            debug_file.puts "palavra: " + palavra + ", save: " + save
          end
          aux1 = "";
          aux2 = "";
          if match = palavra.match(/^([[:alpha:]*~]+)-(d[aeo*]s*)-(.+)$/)
            if DEBUG == 1
              debug_file.puts palavra + " matched  /^([[:alpha:]*~]+)-(d[aeo*]s*)-(.+)$/"
              debug_file.puts "palavra: " + palavra + ", save: " + save
            end
            s1, s2, s3 = match.captures
            aux1 = s1
            if aux1.match(/as*$/)
              aux1.gsub!(/as$/, "a")
            else
              flex = check_flexoes(aux1)
              if flex != nil && flex.ntuples == 1
                aux1 = flex[0]["metalema"]
                aux1.gsub!(/\s+$/, "")
              end
            end
            palavra = aux1+"-"+s2+"-"+s3
            if DEBUG == 1
              debug_file.puts "palavra after: " + palavra + ", save: " + save
            end
          elsif match = palavra.match(/^([[:alpha:]*~]+)-([[:alpha:]*~]+)$/)
            if DEBUG == 1
              debug_file.puts palavra + " matched  /^([[:alpha:]*~]+)-([[:alpha:]*~]+)$/"
              debug_file.puts "palavra: " + palavra + ", save: " + save
            end
            s1, s2 = match.captures
      		  aux1 = s1
      		  aux2 = s2
      		  if aux1.match(/as*$/)
      		    aux1.gsub!(/as$/, "a")
            else
              flex = check_flexoes(aux1)
              if flex != nil && flex.ntuples == 1
                aux1 = flex[0]["metalema"]
                aux1.gsub!(/\s+$/, "")
              end
            end
      		  if aux2.match(/as*$/)
      		    aux2.gsub!(/as$/, "a")
            else
              flex = check_flexoes(aux2)
              if flex != nil && flex.ntuples == 1
                aux2 = flex[0]["metalema"]
                aux2.gsub!(/\s+$/, "")
              end
            end
      		  palavra = aux1+"-"+aux2
            if DEBUG == 1
              debug_file.puts "palavra after: " + palavra + ", save: " + save
            end
          end
        end


        # verifica se eh algarismo
        if @alg.include?(palavra)
          next
        end

        # verifica se eh nome proprio
        taq = BD_TAQ(palavra)
        if DEBUG == 1
          debug_file.puts "taq encontrada para " + palavra + ": " + taq.to_s
        end
        if @antropo.key?(ucterm) || @topo.key?(ucterm)
          unless (taq != nil)
            @color[palavra] = @classes['SemDataNomeProprio']
            @taq2[palavra] = @ano
            @conte[palavra] = save
          end
        else

          # classifica a palavra em todos os outros casos
          ti = taq
          if ti != nil # já datada
            oldTAQ = ti
            oldHomo = @homo[palavra]
            if (comparaData(@ano, ti))
              if (@homo.key?(palavra))
                if (oldHomo)
                  @color[palavra] = @classes['Homo']
                  classe_corrente = "Homo"
                else
                  @color[palavra] = @classes['RetrodatouHomonimia']
                  classe_corrente = "RetrodatouHomonimia"
                  flex = check_flexoes(palavra)
                  if flex != nil
                    if DEBUG == 1
                      debug_file.puts "flex encontrada para " + palavra + ": " + flex[0]["metalema"].to_s
                    end
                    flex.each do |f|
                      desflex = f["metalema"]
                      desflex.gsub!(/\s+$/, "")
                      desflexOldTAQ = BD_TAQ(desflex)
                      if comparaData(desflexOldTAQ, "1600") == 1
                        @color[palavra] = @classes['Homo']
                        classe_corrente = "Homo"
                      end
                    end
                  end
                end
              elsif ti == "9999"
                @color[palavra] = @classes['SemDataFlex']
                classe_corrente = "SemDataFlex"
                flex = check_flexoes(palavra)
                if flex != nil
                  if DEBUG == 1
                    debug_file.puts "flex encontrada para " + palavra + ": " + flex[0]["metalema"].to_s
                  end
                  flex[0]["metalema"].gsub!(/\s+$/, "")
                  if flex[0]["metalema"] == palavra
                    @color[palavra] = @classes['SemData']
                    classe_corrente = "SemData"
                  end
                else
                  @color[palavra] = @classes['SemData']
                  classe_corrente = "SemData"
                end
              else # retrodatação propria
                @color[palavra] = @classes['RetrodatouFlex']
                classe_corrente = "RetrodatouFlex"
                flex = check_flexoes(palavra)
                if flex != nil
                  if flex.ntuples == 1
                    if DEBUG == 1
                      debug_file.puts "flex encontrada para " + palavra + ": " + flex[0]["metalema"].to_s
                    end
                    flex[0]["metalema"].gsub!(/\s+$/, "")
                    if flex[0]["metalema"] != palavra
                      desflexOldTAQ = taq
                      if comparaData(desflexOldTAQ, "1600") == 1
                        @color[palavra] = @classes['Homo']
                        classe_corrente = "Homo"
                      end
                    else
                      @color[palavra] = @classes['Retrodatou']
                      classe_corrente = "Retrodatou"
                    end
                  else
                    flex.each do |f|
                      desflex = f["metalema"]
                      desflex.gsub!(/\s+$/, "")
                      desflexOldTAQ = taq
                      if comparaData(desflexOldTAQ, "1600") == 1
                        @color[palavra] = @classes['RetrodatouHomonimia']
                        classe_corrente = "RetrodatouHomonimia"
                      end
                    end
                  end
                else
                  @color[palavra] = @classes['Retrodatou']
                  classe_corrente = "Retrodatou"
                end
              end #retrodatação propria
              @taq2[palavra] = @ano
              @conte[palavra] = save
            else
              # Não retrodatou
              if DEBUG == 1
                debug_file.puts "Nao retrodatou, portanto nao moida"
              end
            end

          flex = check_flexoes(palavra)
        elsif flex != nil && flex.ntuples != 0 #1465
            p flex
            if flex.ntuples == 1
              if DEBUG == 1
                debug_file.puts "flex encontrada para " + palavra + ": " + flex[0]["metalema"].to_s
              end
              palavra = flex[0]["metalema"]
              palavra.gsub!(/\s+$/, "")
              ti = 0
              ti = BD_TAQ(palavra)
              if ti != nil
                oldHomo = @homo[palavra]
                if comparaData(@ano, ti)
                  if @homo.key?(palavra)
                    if oldHomo
                      @color[palavra] = @classes['Homo']
                      classe_corrente = "Homo"
                    else
                      @color[palavra] = @classes['RetrodatouHomonimia']
                      classe_corrente = "RetrodatouHomonimia"
                    end
                  elsif ti == "9999"
                    @color[palavra] = @classes["SemData"]
                    classe_corrente = "SemData"
                  else
                    @color[palavra] = @classes['Retrodatou']
                    classe_corrente = "Retrodatou"
                  end
                  @taq2[palavra] = @ano
                  @conte[palavra] = save
                end
              else
                if save.match(/mente$/)
                  @color[palavra] = @classes['InexistenteAdverbioModo']
                  classe_corrente = "InexistenteAdverbioModo"
                  @taq2[palavra] = @ano
                  @conte[palavra] = save
                elsif save.match(/inh[ao]s*$/) != nil
                  match = palavra.match(/(.+)inh([ao])s$/)
                  if match != nil
                    s1, s2 = match.captures
                    palavra = s1 + "inh" + s2
                  end
                  @color[palavra] = @classes["InexistenteDiminutivo"]
                  classe_corrente = "InexistenteDiminutivo"
                  @taq2[palavra] = @ano
                  @conte[palavra] = save
                elsif save.match(/zão$|zões$|zona$|zonas$/)
                  @color[palavra] = @classes['InexistenteAumentativo']
                  classe_corrente = "InexistenteAumentativo"
                  @taq2[palavra] = @ano
                  @conte[palavra] = save
                elsif save.match(/íssim[ao]s*$|ésim[ao]s*$|érrim[ao]s*$|ílim[ao]s*$/)
                  match = palavra.match(/(.+)[ao]s*$/)
                  if match != nil
                    s1 = match.captures
                    palavra = s1 + "o"
                  end
                  @color[palavra] = @classes['InexistenteSuperlativo']
                  classe_corrente = "InexistenteSuperlativo"
                  @taq2[palavra] = @ano
                  @conte[palavra] = save
                elsif !palavra.match(/[aeiouáàâãäéêẽèëíîĩìïóôòõöúûũùüAEIOUÁÂÀÃÄÉÊÈËÍÎĨÌÏÓÔÒÕÖÚÛŨÙÜ]/)
                  @color[palavra] = @classes['InexistenteAbreviatura']
                  classe_corrente = "InexistenteAbreviatura"
                  @taq2[palavra] = @ano
                  @conte[palavra] = save
                elsif palavra.match(/[-]/)
                  @color[palavra] = @classes['InexistenteComposto']
                  classe_corrente = "InexistenteComposto"
                  @taq2[palavra] = @ano
                  @conte[palavra] = save
                else
                  @taq2[palavra] = @ano
                  @conte[palavra] = save
                  @color[palavra] = @classes["Inexistente"]
                  classe_corrente = "Inexistente"
                end
              end
            else
              @taq2[flex[0]["metalema"]] = @ano
              palavra = ""
              flex.each do |f|
                palavra = palavra + f["metalema"] + " "
                # palavra = v.join(" ")
              end
              @color[palavra] = @classes["PossivelHomonimia"]
            end
          else #1655
            if save.match(/mente$/)
              @color[palavra] = @classes['InexistenteAdverbioModo']
              classe_corrente = "InexistenteAdverbioModo"
              @taq2[palavra] = @ano
              @conte[palavra] = save
            elsif save.match(/inh[ao]s*$/)
              match = palavra.match(/(.+)inh([ao])s$/)
              if match != nil
                s1, s2 = match.captures
                palavra = s1 + "inh" + s2
              end
              @color[palavra] = @classes["InexistenteDiminutivo"]
              classe_corrente = "InexistenteDiminutivo"
              @taq2[palavra] = @ano
              @conte[palavra] = save
            elsif save.match(/zão$|zões$|zona$|zonas$/)
              @color[palavra] = @classes['InexistenteAumentativo']
              classe_corrente = "InexistenteAumentativo"
              @taq2[palavra] = @ano
              @conte[palavra] = save
            elsif save.match(/íssim[ao]s*$|ésim[ao]s*$|érrim[ao]s*$|ílim[ao]s*$/)
              match = palavra.match(/(.+)[ao]s$/)
              if match != nil
                s1 = match.captures
                palavra = s1 + "o"
              end
              @color[palavra] = @classes['InexistenteSuperlativo']
              classe_corrente = "InexistenteSuperlativo"
              @taq2[palavra] = @ano
              @conte[palavra] = save
            elsif !palavra.match(/[aeiouáàâãäéêẽèëíîĩìïóôòõöúûũùüAEIOUÁÂÀÃÄÉÊÈËÍÎĨÌÏÓÔÒÕÖÚÛŨÙÜ]/)
              @color[palavra] = @classes['InexistenteAbreviatura']
              classe_corrente = "InexistenteAbreviatura"
              @taq2[palavra] = @ano
              @conte[palavra] = save
            elsif palavra.match(/[-]/)
              @color[palavra] = @classes['InexistenteComposto']
              classe_corrente = "InexistenteComposto"
              @taq2[palavra] = @ano
              @conte[palavra] = save
            else
              @taq2[palavra] = @ano
              @conte[palavra] = save
              @color[palavra] = @classes["Inexistente"]
              classe_corrente = "Inexistente"
            end
          end # 1370 - 1700
        end # 1360 - 1701


        # acrescenta a palavra a ao grupo de palavras
        if @palavras.key?(palavra)
          @palavras[palavra].push([save, cont, id])
          if DEBUG == 1
            debug_file.puts "palavra: " + palavra + ", " + save + " adicionada. contexto: " + cont
            debug_file.puts ""
          end
        else
          @palavras[palavra] = [[save, cont, id]]
          if DEBUG == 1
            debug_file.puts "palavra: " + palavra + ", " + save + " adicionada. contexto: " + cont
            debug_file.puts ""
          end
        end

        i += 1
      end
    end
    if DEBUG == 1
      debug_file.close
    end
  end

end
