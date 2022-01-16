def jyanken_type(human_type, num_str)
  if human_type == 'you' then
    human_str = "あなた："
  else
    human_str = "相手："
  end

  if num_str == '0' then
    hand_type = 'グー'
  elsif num_str == '1' then
    hand_type = 'チョキ'
  else
    hand_type = 'パー'
  end
  hantei_message = "#{human_str}#{hand_type}を出しました"
  return hantei_message
end


def muite_hoi(human_type,num_str)
  if human_type == 'you' then
    human_str = "あなた："
  else
    human_str = "相手："
  end

  if num_str == '0' then
    hoi_hand_type = '上'
  elsif num_str == '1' then
    hoi_hand_type = '下'
  elsif num_str == '2'
    hoi_hand_type = '左'
  else 
    hoi_hand_type = '右'
  end
  hantei_message = "#{human_str}#{hoi_hand_type}"
  return hantei_message
end


def jyanken_hantei(num_str)
  if num_str == '01' or num_str == '12' or num_str == '20' then
    hantei = 'Win'
  elsif num_str == '02' or num_str == '10' or num_str == '21' then
    hantei = 'Lose'
  else
    hantei = 'Aiko'
  end
  return hantei
end


def muite_hantei(num_str01,num_str02)
  if num_str01 == num_str02 then
    hantei = 'OK'
  else
    hantei = 'None'
  end
  return hantei
end


def jyanken_loop(your_hand,tmp_str)
  if your_hand == '3' then
    puts "じゃんけん終了"
    exit
  elsif your_hand == '0' or your_hand == '1' or your_hand == '2'  then
    pc_hand = rand(0..100).modulo(3) 
    renketu = your_hand + pc_hand.to_s
    hantei = jyanken_hantei(renketu)
    your_message = jyanken_type("you",your_hand)
    pc_message = jyanken_type("pc",pc_hand.to_s)
    puts tmp_str
    puts "-------------------------"
    if hantei == 'Win' then
      puts "\e[31m\e[1m" + "YOU WIN !!" + "\e[0m"
    elsif hantei == 'Lose' then
      puts "\e[34m" + "YOU LOSE..." + "\e[0m"
    end
    puts your_message
    puts pc_message
    puts "-------------------------"
  else
    hantei = 'None'
    puts "無効な入力値です"
    puts "じゃんけん ．．．"
    puts "0(グー) 1(チョキ) 2(パー) 3(戦わない)"
  end
  return hantei
end

str_01 = 'ホイ！'
str_02 = 'ショ！'
max_cnt = 30
mukou_max_cnt = 5
cnt = 0
loop do
  if cnt > max_cnt then
    puts "引き分けです（最大回数#{max_cnt}回を超えました）"
    break
  end
  

  puts "じゃんけん ．．．"
  puts "0(グー) 1(チョキ) 2(パー) 3(戦わない)"
  your_hand = gets.chomp.to_s
  hantei = 'None'
  hantei = jyanken_loop(your_hand,str_01)
  cnt += 1
  mukou_cnt = 0
  while hantei == 'None' do
    mukou_cnt += 1
    if mukou_cnt > mukou_max_cnt then
      puts "無効な入力値の回数が多いため、強制終了します（最大回数#{mukou_max_cnt}回を超えました）"
      exit
    end
    your_hand = gets.chomp.to_s
    hantei = jyanken_loop(your_hand,str_01)
    cnt += 1
  end

  mukou_cnt = 0
  while hantei == 'Aiko' do
    puts "あいこで ．．．"
    puts "0(グー) 1(チョキ) 2(パー) 3(戦わない)"
    your_hand = gets.chomp.to_s
    hantei = jyanken_loop(your_hand,str_02)  
    cnt += 1
    while hantei == 'None' do
      mukou_cnt += 1
      if mukou_cnt > mukou_max_cnt then
        puts "無効な入力値の回数が多いため、強制終了します（最大回数#{mukou_max_cnt}回を超えました）"
        exit
      end
      your_hand = gets.chomp.to_s
      hantei = jyanken_loop(your_hand,str_01)
      cnt += 1
    end
  end

  puts "あっち向いて〜"
  if hantei == 'Win' then
    puts "\e[31m" + "指を指す方向を決めてください" + "\e[0m"
  else
    puts "\e[34m" + "顔を向く方向を決めてください" + "\e[0m"  
  end
  puts "0(上) 1(下) 2(左) 3(右)"
  your_hoi_hand = gets.chomp.to_s
  mukou_cnt = 0
  loop do 
    if your_hoi_hand == '0' or your_hoi_hand == '1' or your_hoi_hand == '2' or your_hoi_hand == '3' then
      break
    else 
      mukou_cnt += 1
      if mukou_cnt > mukou_max_cnt then
        puts "無効な入力値の回数が多いため、強制終了します（最大回数#{mukou_max_cnt}回を超えました）"
        exit
      end
      puts "無効な入力値です"
      puts "あっち向いて〜"
      if hantei == 'Win' then
        puts "\e[31m" + "指を指す方向を決めてください" + "\e[0m"
      else
        puts "\e[34m" + "顔を向く方向を決めてください" + "\e[0m"  
      end    
      puts "0(上) 1(下) 2(左) 3(右)"
      your_hoi_hand = gets.chomp.to_s
    end
  end
  pc_hoi_hand = rand(0..100).modulo(4)
  hoi_hantei = muite_hantei(your_hoi_hand,pc_hoi_hand.to_s)
  your_message = muite_hoi("you",your_hoi_hand)
  pc_message = muite_hoi("pc",pc_hoi_hand.to_s)
  puts str_01
  puts "-------------------------"
  puts your_message
  puts pc_message
  puts "-------------------------"

  if hoi_hantei == 'OK' then
    if hantei == 'Win' then
      puts "\e[31m\e[1m\e[5m" + "！！ おめでとうございます ！！".center(20)
      puts "〜あなたの勝利です〜".center(20) + "\e[0m"
      puts "Thank you for playing."
      exit
    else
      puts "\e[34m" + "残念（ ｉ _ ｉ ）"
      puts "あなたの敗北です。再挑戦しますか？" + "\e[0m"
      puts "y(再挑戦) n(終了)"
      retry_mode = gets.chomp.to_s
      
      cnt = 0
      mukou_cnt = 0
      loop do
        mukou_cnt += 1
        if mukou_cnt > mukou_max_cnt then
          puts "無効な入力値の回数が多いため、強制終了します（最大回数#{mukou_max_cnt}回を超えました）"
          exit
        end

        if retry_mode == 'n' then
          puts "\e[7m" + "またのチャレンジをおまちしております".center(22)
          puts "Thank you for playing.".center(40)
          puts "GAME OVER".center(40) + "\e[0m"
          exit
        elsif retry_mode == 'y' then
          break
        else
          puts "無効な入力値です"
          puts "y(再挑戦) n(終了)"
          retry_mode = gets.chomp.to_s
        end
      end
    end
  end
end
