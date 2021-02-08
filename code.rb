###################################################################
# thread 0
###################################################################
use_bpm 145


chords = [(chord :G, :m9), (chord :A, :m), (chord :D, :m7), (chord :C, :major)].ring
c = chords[0]

live_loop :keys do
  with_fx :reverb, mix: 0.2 do
    use_synth :dark_ambience
    play c, amp: 7
    sleep 0.5
  end
end

live_loop :manage do
  4.times do
    sleep 8
    c = chords.tick
  end
end

live_loop :melody do
  with_fx :reverb, mix: 0.5 do
    use_synth :hollow
    r = [0.25, 0.25, 0.5, 1].choose
    play c.choose, attack: 0, release: r
    sleep r
  end
end

live_loop :melody2 do
  with_fx :reverb, mix: 0.6 do
    use_synth :prophet
    #r = [0.25, 0.25, 0.5, 1].choose
    play c.choose, attack: 0, release: 0.25, amp: 0.4
    sleep 0.25
  end
end

###################################################################
# thread 1
###################################################################

define :hihat do |amp_amount, sleep_amount|
  with_fx :ping_pong, mix: 0.7 do
    with_fx :reverb, mix: 0.1 do
      sample "/Desktop/Samples/hihat.wav", amp: amp_amount
      sleep sleep_amount
    end
  end
end

live_loop :kick do
  4.times do
    normal_kick 1, 1
  end
end

live_loop :kicks2 do
  4.times do
    odd_kick 1, 0.75
  end
end

live_loop :snare do
  4.times do
    snare 0.6, 2
  end
end

live_loop :hihat do
  with_fx :ping_pong, mix: 0.7 do
    with_fx :reverb, mix: 0.1 do
      # You can also use the function defined before!
      2.times do
        #hihat 0.1, 0.25
        sample "/Desktop/Samples/hihat.wav", amp: 0.1
        sleep 0.25
      end
      1.times do
        #hihat 0.35, 0.25
        sample "/Desktop/Samples/hihat.wav", amp: 0.35
        sleep 0.25
      end
      1.times do
        #hihat 0.2, 0.25
        sample "/Desktop/Samples/hihat.wav", amp: 0.2
        sleep 0.25
      end
    end
  end
end
