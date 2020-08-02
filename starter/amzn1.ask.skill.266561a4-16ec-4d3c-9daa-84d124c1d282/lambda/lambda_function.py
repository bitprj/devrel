# -*- coding: utf-8 -*-

# This sample demonstrates handling intents from an Alexa skill using the Alexa Skills Kit SDK for Python.
# Please visit https://alexa.design/cookbook for additional examples on implementing slots, dialog management,
# session persistence, api calls, and more.
# This sample is built using the handler classes approach in skill builder.
import logging
import ask_sdk_core.utils as ask_utils
import random
from ssml-builder.core import Speech
from ask_sdk_core.skill_builder import SkillBuilder
from ask_sdk_core.dispatch_components import AbstractRequestHandler
from ask_sdk_core.dispatch_components import AbstractExceptionHandler
from ask_sdk_core.handler_input import HandlerInput

from ask_sdk_model import Response

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)



class LaunchRequestHandler(AbstractRequestHandler):
    """Handler for Skill Launch."""
    def can_handle(self, handler_input):
        # type: (HandlerInput) -> bool

        return ask_utils.is_request_type("LaunchRequest")(handler_input)

    def handle(self, handler_input):
        # type: (HandlerInput) -> Response
        speak_output = "Welcome to Roulette, would you like to bet on color or number"

        return (
            handler_input.response_builder
                .speak(speak_output)
                .ask(speak_output)
                .response
        )




class HelpIntentHandler(AbstractRequestHandler):
    """Handler for Help Intent."""
    def can_handle(self, handler_input):
        # type: (HandlerInput) -> bool
        return ask_utils.is_intent_name("AMAZON.HelpIntent")(handler_input)

    def handle(self, handler_input):
        # type: (HandlerInput) -> Response
        
        speak_output = "You can say hello to me! How can I help?"

        return (
            handler_input.response_builder
                .speak(speak_output)
                .ask(speak_output)
                .response
        )


class CancelOrStopIntentHandler(AbstractRequestHandler):
    """Single handler for Cancel and Stop Intent."""
    def can_handle(self, handler_input):
        # type: (HandlerInput) -> bool
        return (ask_utils.is_intent_name("AMAZON.CancelIntent")(handler_input) or
                ask_utils.is_intent_name("AMAZON.StopIntent")(handler_input))

    def handle(self, handler_input):
        # type: (HandlerInput) -> Response
        speak_output = "Goodbye!"

        return (
            handler_input.response_builder
                .speak(speak_output)
                .response
        )


class SessionEndedRequestHandler(AbstractRequestHandler):
    """Handler for Session End."""
    def can_handle(self, handler_input):
        # type: (HandlerInput) -> bool
        return ask_utils.is_request_type("SessionEndedRequest")(handler_input)

    def handle(self, handler_input):
        # type: (HandlerInput) -> Response

        # Any cleanup logic goes here.

        return handler_input.response_builder.response


class IntentReflectorHandler(AbstractRequestHandler):
    """The intent reflector is used for interaction model testing and debugging.
    It will simply repeat the intent the user said. You can create custom handlers
    for your intents by defining them above, then also adding them to the request
    handler chain below.
    """
    def can_handle(self, handler_input):
        # type: (HandlerInput) -> bool
        return ask_utils.is_request_type("IntentRequest")(handler_input)

    def handle(self, handler_input):
        # type: (HandlerInput) -> Response
        intent_name = ask_utils.get_intent_name(handler_input)
        speak_output = "You just triggered " + intent_name + "."

        return (
            handler_input.response_builder
                .speak(speak_output)
                # .ask("add a reprompt if you want to keep the session open for the user to respond")
                .response
        )


class CatchAllExceptionHandler(AbstractExceptionHandler):
    """Generic error handling to capture any syntax or routing errors. If you receive an error
    stating the request handler chain is not found, you have not implemented a handler for
    the intent being invoked or included it in the skill builder below.
    """
    def can_handle(self, handler_input, exception):
        # type: (HandlerInput, Exception) -> bool
        return True

    def handle(self, handler_input, exception):
        # type: (HandlerInput, Exception) -> Response
        logger.error(exception, exc_info=True)

        speak_output = "Sorry, I had trouble doing what you asked. Please try again."

        return (
            handler_input.response_builder
                .speak(speak_output)
                .ask(speak_output)
                .response
        )

class colorIntentHandler(AbstractRequestHandler):
    

    def can_handle(self, handler_input):
        return ask_utils.is_intent_name("ColorIntent")(handler_input)
    
    def handle(self, handler_input):
        input = handler_input.request_envelope.request.intent.slots
        red = {1,3,5,7,9,12,14,16,18,19,21,23,25,27,30,32,34,36}
        black = {2,4,6,8,10,11,13,15,17,20,22,24,26,28,29,31,33,35}
        green = {0}
        randomVal = random.randint(0,36)
        if randomVal in red:
            randCol = "red"
        elif randomVal in black:
            randCol = "black"
        else:
            randCol = "green"
        
        if (input["color"].value == randCol):
            speak_output = "your bet on" +input["color"].value +"has won"
        else:
            speak_output = "the winning choice was "+ randCol + " and your choice of " +input["color"].value +" has lost"
        
        return (
            handler_input.response_builder
            .speak(speak_output)
            .response
        )
class numberIntentHandler(AbstractRequestHandler):
    
            
    def can_handle(self, handler_input):
        return ask_utils.is_intent_name("NumberIntent")(handler_input)
    
    def handle(self, handler_input):
        input = handler_input.request_envelope.request.intent.slots
        randomVal = random.randint(0,36)
        
        if (input["number"].value == randomVal):
            speak_output = "congrats your bet on" + input["number"].value + "has won!"
        else:
            speak_output = "Sorry the result was" + randomVal + " and you chose" + input["number"].value
        return (
            handler_input.response_builder
                .speak(speak_output)
                .response
            )
class RouletteIntentHandler(AbstractRequestHandler):
    red = {1,3,5,7,9,12,14,16,18,19,21,23,25,27,30,32,34,36}
    black = {2,4,6,8,10,11,13,15,17,20,22,24,26,28,29,31,33,35}
    green = {0}
    def spinWheel():
        randomVal = random.randInt(0,36)
        if randomVal in red:
            return ('red', randomVal)
        elif randomVal in black:
            return ('black', randomVal)
        else:
            return ('green', randomVal)
        
            
    def can_handle(self, handler_input):
        return ask_utils.is_intent_name("RouletteIntent")(handler_input)
    
    def handle(self, handler_input):
        input = handler_input.request_envelope.request.intent.slots
        
        if (input["betType"].value == "color"):
            speak_output = "What color will you choose, green red or black"
        elif (input["betType"].value == "number"):
            speak_output = "What number will you choose, 0 to 36"
        else:
            speak_output = "Please choose color or number"
        
        
        return (
            handler_input.response_builder
                .speak(speak_output)
                .response
        )
# The SkillBuilder object acts as the entry point for your skill, routing all request and response
# payloads to the handlers above. Make sure any new handlers or interceptors you've
# defined are included below. The order matters - they're processed top to bottom.


sb = SkillBuilder()

sb.add_request_handler(LaunchRequestHandler())
sb.add_request_handler(RouletteIntentHandler())
sb.add_request_handler(numberIntentHandler())
sb.add_request_handler(colorIntentHandler())
sb.add_request_handler(HelpIntentHandler())
sb.add_request_handler(CancelOrStopIntentHandler())

sb.add_request_handler(SessionEndedRequestHandler())
sb.add_request_handler(IntentReflectorHandler()) # make sure IntentReflectorHandler is last so it doesn't override your custom intent handlers

sb.add_exception_handler(CatchAllExceptionHandler())

lambda_handler = sb.lambda_handler()