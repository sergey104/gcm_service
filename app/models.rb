# app/models.rb
require 'sinatra'
require 'sinatra/activerecord'
require 'constants'
require 'json'
require 'gcm'
require 'thread'
require 'rubygems'
require 'active_record'

day = Array.new(22);
day = [
   "This fool is far from foolish, he is the wise fool of the Arcana and represents the child like optimism and innocence that ensures whatever we do, if we expect to succeed then of course we will succeed! Drawing the Fool suggests that you 'let go and take a risk' in some area of your life. The fool of the Arcana appears to be about to step off the edge of a cliff, but however disastrous this may seem to us, we know that he will survive! It is an airy card and is linked to the planet Uranus, which is the planet of inspiration, freedom and change, so the Fool is also a card of new beginnings and freedom. When you choose this card as a single daily card, its message to you is to take a fresh look at your day, and see how you can work through it intuitively and in a more carefree manner. Try for once not to care about what others think! Be aware of the Fool like a breath of fresh invigorating air blowing through your life. You may decide that you like the feeling of freedom, and carry it into the rest of your week! Traditionally the Fool has no number in the Tarot. He is the beginning and the end. The wise child starting off on his journey, to return again to the source. We see here the continuing cycle of birth, death and re-birth. The continuing search for Spiritual Enlightenment.",
   "The Magician helps you achieve your goals, and tells you that you have all that you need for success, in whatever area that lies. He is associated with Mercury, the messenger of the Gods. Swift footed and able to change direction in mid air he brings adaptability and humour to your life. When you draw the Magician as a daily card, he announces that you have all that you need for a successful day, it is of course up to you to take advantage of his gift and manifest success. Your communication skills should be fine tuned today, your own and other peoples problems will seem easier than usual to solve. Today, go with your best ideas, retain a sense of fun, try to make work into play. Today trust your intuition and allow new ideas to surface. be careful though' of moving too fast and losing your balance, both physically and emotionally. Enjoy the power of the Magician with care!",
   " Associated with the Moon, when The High Priestess appears she represents heightened perception and a connection with the Arcane. As a daily card she is telling you that today your intuition will be finely tuned, and that you will be aware of many things not always felt. Others will be unable to deceive you...you will see through it all! Pay attention to your daydreams and dreams they will contain messages that are important for you. The High Priestess is the Daughter of the Moon and represent the female and intuitive side, be guided by your intuitive feelings today. Be sure that you do not repress feelings, Not a day for pandering to those who are less than honest about themselves, avoid them at all cost and remain psychically open and aware. When this card appears there is much going on under the surface, Today may be the day to explore the deepest depths and see what emerges!",
   "The Empress represents the powerful female side of our dual nature, she is the fertile Mother/Goddess figure of the Tarot. Associated with Venus and the Triple faced Godesses. As a daily card the Empress confirms that your female, nurturing, tactile side is very evident right now. Firstly remember that it is yourself you must nurture before nurturing others. This is a time when you are brimming over with creativity, and whether it is children or ideas that you are birthing, the result will be the same! Food, Fabrics, rich colours! all draw you to them today, allow yourself to enjoy them all and perhaps if you can make time, treat yourself to something wonderful like a massage or beauty treatment, or if it is your personal weakness...a wonderful bar of chocolate! If you are working, make sure that the area in which you work is pleasant with flowers or some little personal things, and be sure to honour any new and creative ideas that surface today as they will be important and relevant.",
   "The Emperor represents structure and power. As your daily card he tells you that today will be a good day for making plans, looking for new employment (or promotion) or dealing with all kinds of authority. Today you should win all the arguments! You will probably find that this is the day when people come to you for advice, give it freely as you are most likely to be logical and level headed today. However if it is advice on matters of an emotional nature, leave them alone for another day! This card is associated with the sign of Aries and ruled by Mars, Strong a d decisive associations! Today is also the day for building bridges, renewing friendships, making other people happy and most of all being nice to yourself!",
   "The Hierophant represents order and structure in your life. Ruled by the sign of Taurus and with a strong connection to the material world. As a daily card it tells you to pay attention to order and discipline for today, and to pay great attention to detail in your personal life. There could be an instance during the day where you may lose out if you allow something to slip away whilst your not watching, and there could be great benefit to you by being attentive, especially if you are in a learning or work situation. Not a day for spending money, conserve what you have for now! If you are looking for advice today, best to look for a second and unbiased opinion, and do not be too quick to judge either yourself or others. This card also suggests in some circumstances, news of formalizing a relationship, either your own ore that of someone near to you, a cause for celebration!",
   "The Lovers, associated with the sign of Gemini is a many faceted symbol. On one hand it may mean literally a relationship or the possibility of a new lover coming into your life, but more usually it signifies choices. Two or more paths may be opening before you, but with the warning that whichever path you take, it will be unlikely that you will be able return to your old way once more. this may be a life changing time for you, so be sure hat you know all your options! The moral here is look before you leap! As a daily choice you may be required to use your intuition today, to be sure of which direction you take, whether it be in a relationship or in some other part of your life. Asking advice of others may be a waste of time today, today you are your own best guide! The Lovers offers you the opportunity to return to your true life's path!",
   "To travel hopefully is better than to arrive. This then is the true message of the Chariot. By going with, instead of against our nature we succeed, by looking ahead and above we circumvent the potholes in life's road and fly our Chariot to the very stars! Linked to the sign of Cancer and the Moon. As a daily card the Chariot heralds a lucky time for you, but the luck is a result of your hard work, and perhaps failures in the past and the determination to succeed. A special door may begin to open for you today.. but only if you are ready for it! The Chariot may rumble into your life as a real vehicle, or a day of more moving about than you were expecting to, again go with the flow rather than against it. Accept all that the chariot brings, it will ultimately improve your situation.",
   "This is the strength that come from conviction and a generous heart. Strength indicates a fair minded, honest and generous person, but one who is filled with power and optimism arising from strength of character and knowledge of self. This card is ruled by the sign of Leo and is also connected with pleasure, romance and children. If you choose Strength as a daily card you will find the strength to overcome oppression and unfairness, and yet act with honour and fairness yourself! Today you will be filled with hope, and will be able to see the bigger picture. Recent problems will be easier to solve...or at least more managable. You will have the ability to triumph over miserly attitudes and mean-spiritedness, and retain your own integrity. Sail through the day in the knowledge that all is well-----",
   "When the Hermit enters your life as a daily choice, be sure that it is time for you to take time out. This is the symbol of none-action. This card is associated with Virgo, and its number is nine, which is the number of completion. You have reached the end of a phase of your life and it is time to reflect before you move on. At the end of any journey we need to review the way we have travelled and 'be' with the experience, so that we can apply the lessons we have learned to the new phase coming. For today, you may feel a need to be by yourself, even when amongst others. If alone at home, unplug the phone, lock the door, relax and reflect and be in the moment. Silence is golden! for it illuminates the path ahead!",
   "When you draw the Wheel of Fortune you are approaching a time of change when fate takes a hand. Associated with Jupiter 'The luck bringer' As a daily card the Wheel of Fortune warns that today could be a day of surprises! Take the day as it comes, To try to influence the flow would be a waste of time and energy today! Go with the flow and you may find that this surprising day has a pleasant ending. Trying to force results today may bring quite the opposite effect to that which you are hoping for! You may find yourself connecting with someone from your past in an unexpected way, or something that you had thought was finished with may re-emerge. However your day begins, remember to react to every situation with fortitude and balance. By the end of the day you will be wiser.",
   "The card of harmony, natural justice, Karma and balance. Connected to the sign of Libra. As a daily card Justice can indicate that you may be required to make an important choice during the day, and to do so you need a clear and balanced mind. This may herald the beginning of an unsettled time for you, and you may need to review your long term aims. Work however is well aspected as are all routine matters. Not a day however for emotional matters, best leave those for another day, for today's gift to you is one of clear and concise judgement, and seeing the world as it really is without the rose coloured spectacles. A signal also that matters of justice, whether natural or civil law will have successful outcomes.",
   "This card is one of the most powerful of the Major Arcana, its origins reach back almost into pre-history as the symbol of self-sacrifice. Associated with the planet Neptune, planet of dreams and inspiration and mysticism. As a daily card the Hanged Man is suggesting that you are patient and refrain from taking action, even if you find this difficult at the moment. You may on the other hand feel unable to move forward or backward at all! Try to be at ease with the situation, you will not be able to effect changes at the moment no matter how you try, and if by forcing the issue you do gain results of a sort, you may very soon regret it. If you had a definite question in mind when you picked this card, the answer is unequivocally no! You must accept that for now time is suspended for your hopes and dreams.",
   "This card indicates that you are paring down to the minimum to deal with a massive change in your life. You may be breaking up or under great duress. You might be worried about your job and out of touch with the world around you as obsessions about the economy become preoccupations. You might be involved with a foreclosure or other tragic loss of personal property. One thing about the Death card is that it is impossible to fight. You might want to consider accepting the fate that has occurred and seek to work within it today for a happier tomorrow.",
   "The balancing of elements, water, air, earth and fire all seen in the Temperance card. Connected with Sagittarius, the sign representing the blending of two forms (our human and spiritual nature). As a daily choice, Temperance brings balance and adaptability to your day. You should feel calm and in control of events around you. Things that might normally throw you into disarray will be taken in your stride, and you may find yourself as a successful mediator between two or more other people who are in disagreement. Today you may feel well connected to those around you. Work should be easier today and things that have been difficult to get on top of may suddenly be resolved. You may find yourself being more 'laid-back' than usual...and rightly so! You may also be drawn to unusual choices of food today, preferring hot and spicy to more bland tastes.",
   "Representing the material world, the Devil is not as frightening a symbol as often first thought. He is linked with the sign of Capricorn which controls material needs and responsibilities, duty and power. He is also connected to the Base and Solar Plexus Chakra's. As a daily card he warns you to be on your guard against either being in, or causing a controlling situation! whether it be concerning material matters, or more likely relationships. Lust is also covered by this symbol, and is sometimes a serious warning against the abuse of sexual power to manipulate in relationships. Today watch out for the controlling influences in your life, With balance and optimism today you can side step them and leave the controllers feeling slightly confused and silly! Take care with money matters too, not a day for a spending spree!",
   "The card of transformation! bringing freedom and enlightenment in its wake. Connected to Mars the planet of war. For a daily card the Tower warns you to take great care to keep hold of your temper today, no matter how provoked! There may well be situations that challenge your patience, and you may have to work hard to deal with them. When change comes (as it surly will today) it will be suddenly and without warning, it will feel alarming but is not necessarily bad. When the dust settles you could find yourself in a totally new and undreamed of situation! If you look deeper into this you may see that long term it may be to your benefit no matter how uncomfortable it may initially seem. Remember-\"Too much security is the mother of danger and the grandmother of destruction\"",
   "This is the star of hope! Of energy renewed and of new horizons! When the Star shines into your life as a daily card, it brings peace and renewed energy in its wake. Associated with Aquarius, the Star brings together the energies of air and water to add vigour and flow to your life. Today, you may find yourself in the position of \"healer\" or comforter to others, accept this gladly as through healing others we are ourselves healed! Healing may come in many forms, even as simply 'listening'. Today you may be called upon for service to others, tomorrow you may need the service of others! be sure that the gifts that you give will be many times returned. A connection with nature in all of its forms would benefit you at this time.",
   "The Moon is the ruler of the tides and of all our emotional natures. As a daily card she tells us that today we are perhaps more intuitive than usual, we may be going through a period of vivid and disturbing dreams, or finding that we know far more than we should know of certain situations. The power of the Moon is awakening us! When you draw the Moon you will be acutely aware of your Psychic side, and may be led to make decisions on feelings alone. This is as it should be! The Moon is linked to the planet Pisces, which is related to dreams, visions and creativity. You may think about starting something new, or re-decorating your living space in new and mysterious colour combinations! Colours will be important to you today! Today is not a day for socializing however, Take time and space (if possible) to just \"Be\" and see what new and exciting ideas are born with your relationship with your Psychic/intuitive side!",
   "Bright forces, Joy and Glory. Love, warmth of feelings, happy events, children, All are represented by the warmth of the Sun. Associated with the sign of Leo, it also covers creativity, self-expression and romance. As a daily card, the Sun tells you that things are likely to go well for you today, especially if you are involved in some happy event or with children. Creativity is also well aspected so starting something new would also be good today. Today is a day to mix with many people, flow with the tide of conversation and exchange of ideas, you may find that you have many to share! There may be a gain for you in a material sense too. A part of your life that has been difficult of late may suddenly be resolved to your satisfaction. Trust in the positive forces of nature for inspiration",
   "Judgment is reflecting your internal conflict about making a big decision. The finality of this choice is quite apparent to you, even if it seems small to others and is perhaps even dismissed by those close to you. The presence of this card can give you little guidance over your choice. While many Tarot cards have a sense of inevitability about them, the Judgment card in the present position is powerful in that your free will is on the line here. All this card represents is that the decision you are about to make is, in fact, an epic one.",
   "Drawing the World means that you have completed a cycle in your life. Associated with the planet Saturn, time, boundaries, self-discipline and challenge. As a daily card it tell you that today should begin a new start with a new focus. What ever situation was relevant yesterday is completed and there is a sense of fulfilment. Today all your energy and attention should be in the present, for it is the present that creates the future! Be brave and bold today! ask for whatever it is that you need, but honour those that give it! and be sure that what you ask for you really do need. A good day for beginning new projects or new work. for buying new things and for being adventurous. If you choose this card as an answer to a question, the answer is yes! Go for it!"

]



ActiveRecord::Base.establish_connection(
    :adapter => "mysql",
    :host => "localhost",
    :database => "gcm"
)

class AndroidUser < ActiveRecord::Base
  def user_id
    @user_id
  end

  def registration_id
    @registration_id
  end
end


class MySQL < ActiveRecord::Base
end

class SQL

  def initialize
    @lock = Mutex.new

  end

  def send_message_to_all_users
    ids = get_all_reg_ids
    mark("ids = " + ids.to_s)
    while get_message_stack_size > 0
      mess = pop_message_from_stack
      mark(mess)
      parsed = JSON.parse(mess)

      ids.each do |reg_id|
        gcm = GCM.new(API_ID)
        options = { data: {message: parsed["body"], url: parsed["url"]}, registration_ids: [reg_id] }
        response = gcm.send(reg_id, options)
        if analyze(response) == 2
          delete_reg_id(reg_id)
        end
        if analyze(response) == 3
          delete_reg_id(reg_id)
        end
        if analyze(response) == 4
          put_in_delay(options)
        end
      end
    end
  end

  def send_message_to_user(reg_id, message)
    if (check_reg_id(reg_id) != 0)
      gcm = GCM.new(API_ID)
      options = {data: {message: message}, registration_ids: [reg_id]}
      response = gcm.send(registration_ids, options)
      analyze(response)
    end
  end

  def add_message(message, id)
    @lock.synchronize {
      @redis.set(message, id)
    }
    @redis.quit
  end

  def add_reg_id(user_id, reg_id)
    @lock.synchronize {
      @redis.hmset("device:" + reg_id, "user_id", user_id)
      @redis.hmset("device:" + reg_id, "reg_id", reg_id)
      @redis.hset("devices", reg_id, user_id)
    }
    @redis.quit
  end

  def check_reg_id(reg_id)
    @redis.exists("device:" + reg_id)
  end

  def delete_reg_id(reg_id)
    @lock.synchronize {
      if @redis.exists("device:" + reg_id) == true
        @redis.del("device:" + reg_id)
        @redis.hdel("devices", reg_id)
      end
    }
    @redis.quit
  end

  def get_all_reg_ids
    @lock.synchronize {
      list = @redis.hkeys("devices")
      @redis.quit
      list
    }
  end

  def push_message_to_stack(message)
    @lock.synchronize {
      @redis.rpush("messages", message)
      @redis.quit
    }
  end

  def pop_message_from_stack
    @lock.synchronize {
      res = @redis.lpop("messages")
      @redis.quit
      res
    }
  end

  def get_message_stack_size
    @lock.synchronize {
      res = @redis.llen("messages")
      @redis.quit
      res
    }
  end

  def put_message_to_arc(message)
    @lock.synchronize {
      res = @redis.incr("next_message_id")
      @redis.hset("messages_arc", res, message)
      @redis.quit
    }
  end

  def put_in_delay(options)
    @lock.synchronize {
      @redis.rpush("delays", options)
      @redis.quit
    }
  end
end

def mark(message)
  target = open("mess.txt", "a")
  target.write(message)
  target.write("\n")
  target.close
end

def analyze(response)
  answer = JSON.parse(response[:body])
  return 1 if answer["success"] == 1
  ret = answer["results"].to_s
  return 2 if ret.include? 'InvalidRegistration'
  return 3 if ret.include? 'NotRegistered'
  return 4 if ret.include? 'Unavailable'
  return 0

end