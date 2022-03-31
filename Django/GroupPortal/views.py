from asyncio.windows_events import NULL
from calendar import month
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


class UnCollectedLeaderboardApi(APIView):
    def get(self,request,user_id):
        leaderboards=Leaderboard.objects.filter(winner_id=user_id,trophy_collected=False)
        listOfLeaderboard=[]
        for single in leaderboards.iterator():
            listOfLeaderboard.append(single.id)
        return Response({
            "Result":str(listOfLeaderboard)
        })  
class LeaderboardApi(APIView):
    #permission_classes = [IsAuthenticated]
    def get(self,request,user_id):
        self.userWonTrophy()
        if(not self.isInLeaderBoard(id=user_id)):
            print("A")
            
            return self.addOrCreateLeaderBoard(user_id=user_id)
        else:
            print("F")
            return self.displayUserLeaderboard(user_id)


    def addOrCreateLeaderBoard(self,user_id):
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

    def displayUserLeaderboard(self,user_id):
        minStartedDate=datetime.datetime.now()-timedelta(days=30)
        leaderboard=Leaderboard.objects.filter(started_date__gte=minStartedDate,winner_id__isnull=True).order_by("started_date")
        outputList=[]
        for single in leaderboard:
            print(single.winner_id)
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
        if(len(outputList)==0):
            return self.addOrCreateLeaderBoard(user_id=user_id)
        elif(len(outputList)==1):
            return Response({
                "Waiting":True
            })
        
        return Response({
            "output":str(outputList)
        })
    def addToAvailableLeaderboard(self):
        minStartedDate=datetime.datetime.now()-timedelta(days=30)
        leaderboards=Leaderboard.objects.filter(started_date__gte=minStartedDate,winner_id__isnull=True)
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
        #Testing Three
        leaderboard=Leaderboard.objects.create(started_date=datetime.datetime.now())
        leaderboard.save()
        try:
            user=CustomUser.objects.get(id=user_id)
        except CustomUser.DoesNotExist:
            return Response({"User Not Found":True})
        leaderboardPlayer= LeaderboardPlayers.objects.create(player_id=user, leaderboard_id=leaderboard)
        
        
        leaderboardPlayer.save()
        #Testing Four
        haveOtherPlayer=False#self.addUserToNewLeaderbaord(leaderboard.id)
        if(haveOtherPlayer):
            print("Hello")
        else:
                return Response(
            {
                "Waiting":True
            }
        )

    def userWonTrophy(self):
        minStartedDate=datetime.datetime.now()-timedelta(days=30)
        leaderboard=Leaderboard.objects.filter(started_date__lte=minStartedDate,winner_id__isnull=True)
        firstLeaderboard=NULL
        
        for first in leaderboard.iterator():
            firstLeaderboard=first
            leaderboardPlayers=LeaderboardPlayers.objects.filter(leaderboard_id=firstLeaderboard)
            highestPointUser=0
            highestPoint=0
            for single in leaderboardPlayers:
                userPoints=self.getUserTotalCoins(single.player_id)
                if(userPoints>highestPoint):
                    highestPoint=userPoints
                    highestPointUser=single.player_id
            if(highestPoint!=0):
                first.winner_id=highestPointUser
                first.save()

    def isInLeaderBoard(self,id):
        isInLeaderBoard=False
        leaderboardPlayers=LeaderboardPlayers.objects.filter(player_id=id)
        for single in leaderboardPlayers:
            dateOfLeaderboard=datetime.datetime.now().date()-single.leaderboard_id.started_date
        
            if(dateOfLeaderboard.days<=30 and single.leaderboard_id.winner_id is None):
                isInLeaderBoard=True
                break
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
    
