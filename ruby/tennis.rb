
class Player
  def initialize(name, points)
    @name = name
    @points = points
  end

  attr_reader :name
  attr_accessor :points

  def won_point
    @points += 1
  end
end

class TennisGame1

  def initialize(player1Name, player2Name)
    @player1 = Player.new(player1Name, 0)
    @player2 = Player.new(player2Name, 0)
    @player1_points = 0
    @player2_points = 0
  end
        
  def won_point(playerName)
    playerName == @player1.name ? @player1_points += 1 : @player2_points += 1
    playerName == @player1.name ? @player1.won_point : @player2.won_point
  end
  
  def score
    return "Deuce" if duce?
    return advantage_or_win if advantage_or_win?
    return tied_result if point_difference == 0
    to_result(@player1_points) + "-" + to_result(@player2_points)
  end

  def advantage_or_win?
    @player1_points>=4 or @player2_points>=4
  end

  def advantage_or_win
    if (point_difference.abs == 1)
      result = advantage
    else
      point_difference >= 2 ? "Win for #{@player1.name}" : "Win for #{@player2.name}"
    end
  end

  def duce?
    (@player1_points >= 3 || @player2_points >= 3) && point_difference == 0
  end

  def advantage
    result = point_difference == 1 ? "Advantage #{@player1.name}" : "Advantage #{@player2.name}"
  end

  def point_difference
    @player1_points-@player2_points
  end

  def tied_result
    {
      0 => "Love-All",
      1 => "Fifteen-All",
      2 => "Thirty-All",
    }[@player1_points]
  end

  def to_result(point_score)
    {
      0 => "Love",
      1 => "Fifteen",
      2 => "Thirty",
      3 => "Forty",
    }[point_score]
  end
end

class TennisGame2
  def initialize(player1Name, player2Name)
    @player1Name = player1Name
    @player2Name = player2Name
    @p1points = 0
    @p2points = 0
  end
      
  def won_point(playerName)
    if playerName == @player1Name
      p1Score()
    else
      p2Score()
    end
  end

  def score
    result = ""
    if (@p1points == @p2points and @p1points < 3)
      if (@p1points==0)
        result = "Love"
      end
      if (@p1points==1)
        result = "Fifteen"
      end
      if (@p1points==2)
        result = "Thirty"
      end
      result += "-All"
    end
    if (@p1points==@p2points and @p1points>2)
        result = "Deuce"
    end
    
    p1res = ""
    p2res = ""
    if (@p1points > 0 and @p2points==0)
      if (@p1points==1)
        p1res = "Fifteen"
      end
      if (@p1points==2)
        p1res = "Thirty"
      end
      if (@p1points==3)
        p1res = "Forty"
      end
      p2res = "Love"
      result = p1res + "-" + p2res
    end
    if (@p2points > 0 and @p1points==0)
      if (@p2points==1)
        p2res = "Fifteen"
      end
      if (@p2points==2)
        p2res = "Thirty"
      end
      if (@p2points==3)
        p2res = "Forty"
      end
      
      p1res = "Love"
      result = p1res + "-" + p2res
    end
    
    if (@p1points>@p2points and @p1points < 4)
      if (@p1points==2)
        p1res="Thirty"
      end
      if (@p1points==3)
        p1res="Forty"
      end
      if (@p2points==1)
        p2res="Fifteen"
      end
      if (@p2points==2)
        p2res="Thirty"
      end
      result = p1res + "-" + p2res
    end
    if (@p2points>@p1points and @p2points < 4)
      if (@p2points==2)
        p2res="Thirty"
      end
      if (@p2points==3)
        p2res="Forty"
      end
      if (@p1points==1)
        p1res="Fifteen"
      end
      if (@p1points==2)
        p1res="Thirty"
      end
      result = p1res + "-" + p2res
    end
    if (@p1points > @p2points and @p2points >= 3)
      result = "Advantage " + @player1Name
    end
    if (@p2points > @p1points and @p1points >= 3)
      result = "Advantage " + @player2Name
    end
    if (@p1points>=4 and @p2points>=0 and (@p1points-@p2points)>=2)
      result = "Win for " + @player1Name
    end
    if (@p2points>=4 and @p1points>=0 and (@p2points-@p1points)>=2)
      result = "Win for " + @player2Name
    end
    result
  end

  def setp1Score(number)
    (0..number).each do |i|
        p1Score()
    end
  end

  def setp2Score(number)
    (0..number).each do |i|
      p2Score()
    end
  end

  def p1Score
    @p1points +=1
  end
  
  def p2Score
    @p2points +=1
  end
end

class TennisGame3
  def initialize(player1Name, player2Name)
    @p1N = player1Name
    @p2N = player2Name
    @p1 = 0
    @p2 = 0
  end
      
  def won_point(n)
    if n == @p1N
        @p1 += 1
    else
        @p2 += 1
    end
  end
  
  def score
    if (@p1 < 4 and @p2 < 4) and (@p1 + @p2 < 6)
      p = ["Love", "Fifteen", "Thirty", "Forty"]
      s = p[@p1]
      @p1 == @p2 ? s + "-All" : s + "-" + p[@p2]
    else
      if (@p1 == @p2)
        "Deuce"
      else
        s = @p1 > @p2 ? @p1N : @p2N
        (@p1-@p2)*(@p1-@p2) == 1 ? "Advantage " + s : "Win for " + s
      end
    end
  end
end
