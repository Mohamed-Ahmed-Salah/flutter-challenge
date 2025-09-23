enum PageState {
  letsGetStarted("Let's Get Started"),
  next("Next"),
  finish("Finish"),
  analysing("Analysing..."),
  seeResult("See Result"),
  buyPlan("Buy plan");

  final String text;

  const PageState(this.text);
}
