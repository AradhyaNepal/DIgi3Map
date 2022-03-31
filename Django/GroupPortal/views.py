from asyncio.windows_events import NULL
from rest_framework.response import Response
from rest_framework.views import APIView
from auth_pg.models import CustomUser
from .models import Leaderboard,LeaderboardPlayers
import datetime
from rest_framework.permissions import IsAuthenticated
from datetime import timedelta
from Coins.models import Coin
from chain.models import Chain
from habit.models import Habit
from habit.models import Domain
class LeaderboardApi(APIView):
    #permission_classes = [IsAuthenticated]
    def get(self,request,user_id):
        
        if(not self.isInLeaderBoard(id=user_id)):
            print("A")
            if(self.userWonTrophy(user_id)):# This testing
                print("B")
                self.createLeaderBoard(user_id=user_id)
                return Response(
                    {
                        "TrophyWinner":True
                    }
                )
            availableLeaderboard=self.addToAvailableLeaderboard()
            if(availableLeaderboard != NULL):

                try:
                    print("C")
                    user=CustomUser.objects.get(id=user_id)
                    leaderboard=LeaderboardPlayers(leaderboard_id=availableLeaderboard,player_id=user)
                    leaderboard.save()
                    return self.displayUserLeaderboard(user_id)
                except CustomUser.DoesNotExist:
                    print("D")
                    print("Hello")
            else:
               print("E")
               return self.createLeaderBoard(user_id=user_id) 
        else:
            print("F")
            return self.displayUserLeaderboard(user_id)

    def displayUserLeaderboard(self,user_id):
        today_date=datetime.datetime.now()
        leaderboard=Leaderboard.objects.filter(started_date__lte=today_date).order_by("started_date")
        outputList=[]
        for single in leaderboard:
            leaderboardPlayer=LeaderboardPlayers.objects.filter(leaderboard_id=single.id)
            for singlePlayer in leaderboardPlayer:
                outputList.append(
                    {
                        "id":singlePlayer.player_id.id,
                        "name":singlePlayer.player_id.username,
                        "coin":self.getUserTotalCoins(user_id=singlePlayer.player_id.id),
                        "imageUrl":"asdf",
                        "isAnonymous":False
                    }
                )
            break
        if(len(outputList)==1):
            return Response({
                "Waiting":True
            })
        return Response({
            "output":str(outputList)
        })
    def addToAvailableLeaderboard(self):
        today_date=datetime.datetime.now()
        leaderboards=Leaderboard.objects.filter(started_date__lte=today_date)
        availableLeaderboard=0
        for single in leaderboards.iterator():
            leaderboardsPlayers=LeaderboardPlayers.objects.filter(leaderboard_id=single.id)
            count=0
            for singleSub in leaderboardsPlayers.iterator():
                count=count+1
            if(count>0 and count<10):
                availableLeaderboard=single
        return availableLeaderboard

    def createLeaderBoard(self,user_id):
        leaderboard=Leaderboard.objects.create(started_date=datetime.datetime.now())
        leaderboard.save()
        try:
            user=CustomUser.objects.get(id=user_id)
        except CustomUser.DoesNotExist:
            return Response({"User Not Found":True})
        leaderboardPlayer= LeaderboardPlayers.objects.create(player_id=user, leaderboard_id=leaderboard)
        
        
        leaderboardPlayer.save()
        haveOtherPlayer=False#self.addUserToNewLeaderbaord(leaderboard.id)
        if(haveOtherPlayer):
            print("Hello")
        else:
                return Response(
            {
                "Waiting":True
            }
        )

    def userWonTrophy(self,user_id):
        today_date=datetime.datetime.now()
        leaderboard=Leaderboard.objects.filter(started_date__lt=today_date).order_by("started_date")
        firstLeaderboard=NULL
        highestPointUser=0
        for first in leaderboard.iterator():
            firstLeaderboard=first
            leaderboardPlayers=LeaderboardPlayers.objects.filter(leaderboard_id=firstLeaderboard)
            
            highestPoint=0
            for single in leaderboardPlayers:
                userPoints=self.getUserTotalCoins(single.player_id)
                if(userPoints>highestPoint):
                    highestPoint=userPoints
                    highestPointUser=single.player_id
            if(highestPoint!=0):
                first.winner_id=highestPointUser
                first.save()
            break
        return highestPointUser==user_id 

    def isInLeaderBoard(self,id):
        isInLeaderBoard=False
        leaderboardPlayers=LeaderboardPlayers.objects.filter(player_id=id)
        for single in leaderboardPlayers:
            dateOfLeaderboard=datetime.datetime.now().date()-single.leaderboard_id.started_date
            if(dateOfLeaderboard.days<=30):
                isInLeaderBoard=True
        return isInLeaderBoard

    def getUserTotalCoins(self,user_id):
        
        mileStoneCoins=Coin.objects.filter(user_id=user_id)
        mileTotalStoneCoin=0
        for singleCoin in mileStoneCoins.iterator():
            mileTotalStoneCoin=singleCoin.amount+mileTotalStoneCoin
        
        chainCoin=0
        try:
            domains=Domain.objects.filter(user_id=user_id)
            habitsList=[]
            for domain in domains:
                habits=Habit.objects.filter(domain_id=domain.id)
                for habit in habits:
                    habitsList.append(habit.id)
            
            userHabits=Habit.objects.filter(pk__in=habitsList)
            for habit in userHabits:
                chainCoin=chainCoin+self.getHabitChain(habit.id)
        except Habit.DoesNotExist:
            print("Nothing")

        return mileTotalStoneCoin+chainCoin
    
    def getHabitChain(self,habit_id):
        coin=0
        multiplication=1
        chains=Chain.objects.filter(habit_id=habit_id,collected_date__month= datetime.date.today().month).order_by('collected_date')
        
        #outputList.append(ChainSerialzier(chains,many=True).data)

        count=0
        expectedDate=""
        first=True
        expectedList=[]
        for singleChain in chains.iterator():
            coin=coin+1*multiplication
            if(expectedDate==singleChain.collected_date or first):
                first=False
                count=count+1
                multiplication=multiplication+0.1

            else:
                multiplication=1
                count=1
            if(singleChain.collected_date==datetime.date.today()):
                multiplication=1
                count=0
            expectedDate=singleChain.collected_date+ + timedelta(days=1)
            expectedList.append(str(expectedDate)+"  "+str(count))
        return int(coin*5)
    
