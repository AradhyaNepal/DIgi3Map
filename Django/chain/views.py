from .serializer import ChainSerialzier
from rest_framework.response import Response
from rest_framework import status
from rest_framework.views import APIView
from .models import Chain
import json
import datetime
from datetime import timedelta
class ChainAddView(APIView):
    def post(self,request):
       
        serializer=ChainSerialzier(data=request.data)
        if serializer.is_valid():
            habitId=0
            dateCollected=""
            try:
                habitId=serializer.validated_data['habit_id']
                dateCollected=serializer.validated_data['collected_date']
            except:
                return Response(
                        {
                            "details":"Bello"
                        },
                        status=status.HTTP_400_BAD_REQUEST
                    )
                   
            try:
                chainValue=Chain.objects.get(habit_id=habitId,collected_date=dateCollected)
            except Chain.DoesNotExist:
                serializer.save()
                return Response(serializer.data,status=status.HTTP_201_CREATED)
            except Chain.MultipleObjectsReturned:
                return Response(
                    {
                        "details":"Bello"
                    },
                    status=status.HTTP_400_BAD_REQUEST
                )
            return Response(
                {
                    "Chain Already Created":"Yo Yo"
                }
                ,status=status.HTTP_201_CREATED
                )
        return Response(serializer.errors,status=status.HTTP_400_BAD_REQUEST)

class ChainAPIView(APIView):
    def get(self,_,habit_id):

        chains=Chain.objects.filter(habit_id=habit_id,collected_date__month= datetime.date.today().month).order_by('collected_date')
        outputList=[]
        #outputList.append(ChainSerialzier(chains,many=True).data)

        count=0
        allAdded=True
        expectedDate=""
        first=True
        expectedList=[]
        for singleChain in chains.iterator():
           
            if(expectedDate==singleChain.collected_date or first):
                first=False
                count=count+1
                allAdded=False

            else:
                
                allAdded=True
                outputList.append(
                    {
                        "chain":count,
                        "isCurrent":False
                    }
                )
                count=1
            if(singleChain.collected_date==datetime.date.today()):
                
                allAdded=True
                outputList.append(
                    {
                        "chain":count,
                        "isCurrent":True
                    }
                )
                count=0
            expectedDate=singleChain.collected_date+ + timedelta(days=1)
            expectedList.append(str(expectedDate)+"  "+str(count))
        print(str(expectedList))
        if not allAdded:
            outputList.append(
                {
                        "chain":count,
                        "isCurrent":False
                    }
            )
        return Response(outputList,status=status.HTTP_202_ACCEPTED)
    

class ChainCoinApi(APIView):
    def get(self,_,habit_id):
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
        print(str(expectedList))
        
        return Response({"coin":int(coin*5)},status=status.HTTP_202_ACCEPTED)
    
    
    