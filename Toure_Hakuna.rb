"""
Authors: Souleman Toure
Course Name: CSCI 3725
Assignment Name: Hakuna Fermata
Last Updated: 12/14/22
This file contains code that creates the chill music for students to study to!
"""

define :transition do
  """
  This function signals a transition between two sounds or soundscapes!
  The attack and release serve as fades into and out of a note
  The bpm slows down the notes along with the dark_ambience synth to give a certain sound
  """
  use_bpm 20
  use_synth :dark_ambience
  play 50, attack: 1, release: 1
  sleep 1.5
  play 62, attack: 1, release: 3
end


define :rain do
  """
  This function enters into the rain+nature soundscape
  Here we use the sample method to get a choir background with a slowed rate 
  We also sample a downloaded waterfall sound that is looped 
  """
  tempo = 60
  40.times do
    sample "/Users/st/Downloads/waterfall.wav", amp: 0.05, attack: 1, release: 2, rate: 0.8
    use_bpm tempo
    sample :ambi_choir, rate: 0.3 , attack: 3, release: 14, amp: 2
    sleep 1
  end
  sample "/Users/st/Downloads/waterfall.wav", amp: 0.05, attack: 1, release: 2, rate: 0.8
end


define :clearBirds do
  """
  Here we more into a more clear soundscape with birds chirping to put us in nature
  Here the piano synth gives us a melody that I wanted to accompany the birds
  Here we use a f3 scale which gives us all of the notes in a f minor pentatonic scale F Ab Bb C Eb.
  We also use the amp to lower or increase the volumes of certain sounds 
  Our conditional as well adds some variation for the scale giving either the major or minor notes
  """
  sample "/Users/st/Downloads/Free-birds-chirping-sound-effect", amp: 0.1, attack: 5, start:0, finish: 0.35
  60.times do
    use_synth :piano
    use_bpm 15
    play (scale :d3, :major_pentatonic).tick, attack: 4, release: 10, amp: 3
    sleep 0.2
  end
end


define :rainBirds do
  """
  Here we combine the two sounds scapes and sample the rain and birds together
  We slow the the rate of the water to give a heavy and slow sound
  we also lower the amp so that the sounds are not too overwhelming
  """
  use_bpm = 50
  sample "/Users/st/Downloads/Free-birds-chirping-sound-effect", amp: 0.15, attack: 5, start: 0, finish: 0.75
  live_loop :water do
    sample "/Users/st/Downloads/waterfall.wav", amp: 0.05, attack: 1, release: 2, rate: 0.8
    sleep 1
  end
end


define :serenity do
  """
  Serenity allows for a little more variation in the sound and even creating separate songs
  depending on where our condiitonal executes.
  We set the tempo to 60 which is decreased to slow down the notes give a more
  relaxed atmosphere.
  """
  tempo = 60
  live_loop :vibes do
    while (tempo > 0)
      if one_in(2)
        use_bpm tempo
        use_synth :dark_ambience
        play_pattern_timed scale(:c3, :major_pentatonic, num_octaves: 3), 0.125, release: 8
        sleep 4
        play_pattern_timed scale(:e3, :major_pentatonic, num_octaves: 3), 0.125, release: 8
        sleep 4
        play_pattern_timed scale(:f3, :major_pentatonic, num_octaves: 3), 0.125, release: 8
        sleep 4
        tempo -= 10
      else
        use_bpm tempo
        use_synth :dark_ambience
        play_pattern_timed scale(:b3, :minor_pentatonic, num_octaves: 2), 0.125, release: 10
        sleep 4
        play_pattern_timed scale(:b3, :minor_pentatonic, num_octaves: 2), 0.125, release: 10
        sleep 4
        play_pattern_timed scale(:g3, :minor_pentatonic, num_octaves: 2), 0.125, release: 10
        sleep 4
        tempo -= 15
      end
      transition
    end
  end
  break
end


define :main do
  """
  Here is our main function that calls all of the previous functions above.
  """
  transition
  sleep 3
  rain
  transition
  sleep 3
  clearBirds
  transition
  sleep 3
  rainBirds
  serenity
end


main

