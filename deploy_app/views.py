from django.shortcuts import render
from django.http import HttpResponse
import joblib

def welcome(request):
    return render(request, "home.html")

def result(request):
    cls = joblib.load('finalozed_model.sav')
    lis = [
        request.GET.get('RI'),
        request.GET.get('Na'),
        request.GET.get('Mg'),
        request.GET.get('Al'),
        request.GET.get('Si'),
        request.GET.get('K'),
        request.GET.get('Ca'),
        request.GET.get('Ba'),
        request.GET.get('Fe')
    ]
    ans = cls.predict([lis])
    return render(request, "result.html", {'ans': ans, 'lis': lis})
