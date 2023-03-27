import 'dart:async';
import 'package:flutter/material.dart';
import 'package:palana_neurosync/Screens/Edit%20Profile/Vars/Controllers.dart';

import '../ui/profile/view/profilePage.dart';

Color screenColor = Colors.white;
Color bColor = Color.fromARGB(255, 96, 2, 191);
bool alaramOn = false;
TimeOfDay timeOfDay = TimeOfDay.now();

List faqTittle = [
  'What are neurons & neural pathways..?',
  'What is palana Neuro-Sync waves ?',
  'Is there any studies on brain and neurons?',
  'How Palana Neuro-Sync waves works?',
  'How long we have to use\npalana Neuro-Sync waves',
  'How Neuro-Sync waves differ from meditation and',
  'What are the precautions have to be taken before',
  'Who shouldn\'t listen Palana NEURO-sync',
  'What are the preparation for better results ?',
];
List answer = [
  'Neurons are the fundamental units of the brain and nervous system, the cells responsible for receiving sensory input from the external world, for sending motor commands to our muscles, and for transforming and relaying the electrical signals at every step in between roughly 100 billion neurons do interact closely with other cells. A neural pathway is the connection formed by axons that project from neurons to make synapses onto neurons in another location, to enable a signal to be sent from one region of the nervous system to another.',
  'Palana Neuro-Sync waves are specially designed frequencies which helps to rewire our neural pathway easily and effectively',
  'There are so many studies are still going on, and such studies of brain commonly known as neuroscience.EEG recording are important in studying the brain. Neuroscience research has expanded considerably in recent decades. The \'Decade of the Brain\', an initiative of the United States Government in the 1990s, is considered to have marked much of this increase in research, [148] and was followed in 2013 by the BRAIN Initiative. [149] The Human Connectome Project was a five-year study launched in 2009 to analyse the anatomical and functional connections of parts of the brain, and has provided much data.[147]',
  'Neural pathways can be altered by various external stimuli. Auditory stimuli and especially music are among the most interesting. As the famous British neurologist Oliver Sacks states, ä auditory systems & our nervous systems are tuned for music. The brain has many specialized regions which correspond to different processes, thoughts, and sensations. Particular oscillations often reflect distinct regions and networks in the brain communicating with each other. While listening Palana NeuroSync waves (select according to your purpose) will rewire your neural pathways and will get better results.',
  'Palana Neuro-Sync waves working depends on person to person. Generally 21 days to 182 days in the normal course. We suggest to continue up to 90 days for better results.',
  'Neuro-Sync waves makes the use of the fact that the each left and right ears receive embedded peripheral music and it works as music therapy. brain wave frequencies changes the connections among the neurons network in the brain and acts directly in to subconscious mind in a little period that may 21days to 182 days.',
  'Palana Neuro-Sync wave will give you tremendous results. So be serious using this waves. you should not listen this waves while in activity mode especially driving and exercising. Note:  listen Palana NEURO-sync waves only once in a day.  If you are stop listening waves in 30mnts.. you shouldn\'t continue within 12hrs',
  'Children below 10years need not use this waves but, in some cases hyperactive/ mentally challenged child\'s may get wonderful result. Pregnant women should listen only NeuroSync waves specially designed for Pregnancy period * Before listening NeuroSync identify your purpose.',
  'For getting better result fixed a comfortable space and sit or lie down in spinar strength, use high quality head phones, put ur mobile in Do Not Disturbe mode, and the most important thing you are listening this waves to get a life changing result so invest your 1hr daily for 90days.'
];

AddData() {
  NameData.value = editNameController.text;
}



List color1 = [
  Color(0xff94bbe9),
  Color(0xff23015b),
  Color(0xfffa5476),
  Color(0xff3e0088),
  Color(0xff23015b),
  Color(0xfffb3ffa)
];

List color2 = [
  Color(0xff004d2b),
  Color(0xff94bbe9),
  Color(0xff3f5efb),
  Color(0xfffb3ffa),
  Color(0xff94bbe9),
  Color(0xff94bbe9)
];
