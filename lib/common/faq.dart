import 'package:flutter/material.dart';

class FAQ extends StatelessWidget {
  const FAQ({super.key});

  @override
  Widget build(BuildContext context) {
    const accentGreen = Color(0xFF4CAF50);

    final faqs = [
      {
        "question": "What is school security?",
        "answer":
            "School security refers to the policies, procedures, and tools implemented to protect students, staff, and school property from harm or unauthorized access.",
      },
      {
        "question": "Why is school security important?",
        "answer":
            "It ensures a safe learning environment, helps prevent emergencies, and fosters confidence among students, parents, and teachers.",
      },
      {
        "question": "What are common school security measures?",
        "answer":
            "Common measures include ID systems, CCTV cameras, visitor check-ins, emergency drills, and secure access points.",
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Back Button (alone)
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                    size: 22,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // 🔸 Green Help Icon Header (like GetInTouchWithUsPage)
              Center(
                child: Container(
                  width: 53,
                  height: 53,
                  decoration: BoxDecoration(
                    // ignore: deprecated_member_use
                    color: accentGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.help_outline_outlined,
                    color: accentGreen,
                    size: 30,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 🔹 Title
              const Center(
                child: Text(
                  "Frequently Asked Questions",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Sora",
                  ),
                ),
              ),

              const SizedBox(height: 10),

              const Center(
                child: Text(
                  "Find answers to common questions\nabout school safety and security.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Sora",
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // 🧩 FAQ List
              Expanded(
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: ListView.builder(
                    itemCount: faqs.length,
                    itemBuilder: (context, index) {
                      final faq = faqs[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF8F3),
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              // ignore: deprecated_member_use
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                            child: ExpansionTile(
                              tilePadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 4,
                              ),
                              iconColor: accentGreen,
                              collapsedIconColor: accentGreen,
                              childrenPadding:
                                  const EdgeInsets.fromLTRB(16, 0, 16, 16),
                              title: Text(
                                faq["question"]!,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Sora",
                                  fontSize: 15,
                                ),
                              ),
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeInOut,
                                  child: Text(
                                    faq["answer"]!,
                                    style: const TextStyle(
                                      fontFamily: "Sora",
                                      fontSize: 14,
                                      color: Colors.black87,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
