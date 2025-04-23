welcomeScript({
  required String name,
  required String saveTitle,
  required String spendTitle,
  required num saveValue,
  required num spendValue,
}) {
  return [
    "", //0 Pre-Animation Start
    "Greetings, noble saver!", //1
    "I am Lord Rockyfeller, ruler of the Pebbles and your guide to building your Stokpile.", //2
    "Together, we'll replace little indulgences with shiny rewards!", //3
    "Here's the grand idea: You give up a small expense, like daily coffees or snacks.", //4
    "Each time you skip it, you save pebbles that you can stack up for something much more exciting!", //5
    "First, what's your name, dear saver?", //6
    "Splendid! Great to meet you $name! What's something you'd like to give up for a while?", //7
    "It could be that daily coffee out or extra donut you didn't really need.", //8
    "And how much does a $saveTitle cost you each time?", //9
    "This helps us calculate how many pebbles you'll save every time you skip it.", //10
    "Now saving is no fun without a reward! What's a big, shiny reward you'd like to save for?", //11
    "Maybe a massage, a fancy dinner, or maybe even a nice shiny rock!", //12
    "Very nice! And how much does a $spendTitle cost?", //13
    "Enter the total amount, and we'll start stacking up pebbles toward it!", //14
    "Splendid work, $name! Here's the plan:", //15
    "You'll skip a $saveTitle for \$${saveValue.toStringAsFixed(2)} each time...", //16
    "And you're working toward a $spendTitle worth \$${spendValue.toStringAsFixed(2)}.", //17
    "Huzzah! Your journey begins. Remember, every pebble adds up to a magnificent treasure.", //18
    "$name, let's stack those savings together!", //19
    "Let's go!" //20
  ];
}
