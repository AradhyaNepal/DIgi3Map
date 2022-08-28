from .serializer import CoinSerializer
from rest_framework.response import Response
from rest_framework import status
from rest_framework.views import APIView
from .models import Coin
import json

import datetime

class CoinAPIViews(APIView):
    def get(self,_):
        coin=Coin.objects.filter(user_id=id,dateCollected__month= datetime.date.today().month)
        totalCoins=0
        for singleCoin in coin.iterator:
            totalCoins=singleCoin.amount
        return Response(
            {
                "totalcoin":totalCoins
            },
            status=status.HTTP_202_ACCEPTED
            )
    
    def post(self,request):
       
        serializer=CoinSerializer(data=request.data)
        if serializer.is_valid():
            amount=0
            try:
                data=json.loads(request.data)
                amount=int(data['amount'])
            except:
                try:
                    data=request.POST
                    amount=int(data['amount'])
                except:
                    print("fds") 

            print(amount)
            if amount<10 or amount>20:
                return Response("Invalid Coin",status=status.HTTP_400_BAD_REQUEST)
            serializer.save()
            return Response(serializer.data,status=status.HTTP_201_CREATED)
        return Response(serializer.errors,status=status.HTTP_400_BAD_REQUEST)


class CoinUserViews(APIView):
    def get(self,_,id):
        coin=Coin.objects.filter(user_id=id,dateCollected__month= datetime.date.today().month)
        totalCoins=0
        for singleCoin in coin.iterator():
            totalCoins=singleCoin.amount+totalCoins
        return Response(
            {
                "totalcoin":totalCoins
            },
            status=status.HTTP_202_ACCEPTED
            )