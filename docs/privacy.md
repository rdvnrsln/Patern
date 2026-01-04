# Privacy Policy

**Last Updated:** January 2025

**Effective Date:** January 2025

## Introduction

PatternWise ("we," "our," or "us") is committed to protecting your privacy and the privacy of your children. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application (the "App").

## Information We Collect

### Information You Provide

- **Child Profile Information**: Display names, birth month and year (not exact dates), developmental notes, sensitivities, and preferences
- **Observation Data**: Daily logs of sleep, nutrition, activities, emotional events, and developmental milestones
- **Account Information**: Subscription tier and usage statistics

### Information Automatically Collected

- **Device Information**: Device type, operating system version
- **Usage Data**: App features used, analysis requests made, timestamps (anonymized to dates only)

### Information We Do NOT Collect

- **Exact Birth Dates**: We only store birth month and year, not exact dates
- **Location Data**: We do not collect GPS or location information
- **Contact Information**: We do not collect phone numbers, email addresses, or physical addresses
- **Photos or Videos**: We do not collect or store any media files
- **Third-Party Accounts**: We do not integrate with social media or other third-party accounts

## How We Use Your Information

### Local Processing

All data is stored **locally on your device** using industry-standard encryption:

- **AES-GCM Encryption**: All sensitive data is encrypted at rest
- **iOS Keychain**: Encryption keys are stored securely in iOS Keychain
- **File Protection**: Database files use iOS File Protection API

### AI Analysis Service

When you request an analysis, we send **anonymized and aggregated data** to our secure backend service, which then forwards it to third-party AI providers (OpenRouter/DeepSeek). 

**What We Send:**
- Age ranges (e.g., "12-15 months"), not exact ages
- Aggregated metrics (sleep hours, feeding counts, etc.)
- Anonymized behavioral patterns
- Redacted event summaries (all names, locations, and PII removed)

**What We Do NOT Send:**
- Child names or display names
- Exact birth dates or timestamps
- Raw observation logs
- Personal identifiers
- Location information
- Family member names

### Data Anonymization Process

Before sending any data to our backend or AI services, we:

1. **Remove PII**: All names, locations, phone numbers, emails, and addresses are automatically removed
2. **Aggregate Data**: Raw logs are converted to daily aggregates (numbers only)
3. **Redact Events**: Key events are scrubbed of any identifying information
4. **Generalize Ages**: Exact ages are converted to ranges (e.g., "12-15 months")
5. **Remove Timestamps**: Exact times are converted to "days ago" (e.g., "3 days ago")

## Data Sharing and Disclosure

### Third-Party AI Services

We use third-party AI services (OpenRouter/DeepSeek) to provide analysis features. These services receive only anonymized, aggregated data with all PII removed. We have contracts in place requiring these services to:

- Use data only for providing analysis services
- Not use data for training their models
- Delete data after processing
- Maintain appropriate security measures

### Backend Infrastructure

Our backend service (Supabase) processes requests but does not store personal data. All data is processed in memory and discarded after analysis completion.

### We Do NOT:

- Sell your data to third parties
- Share data with advertisers
- Use data for marketing purposes
- Share data with other users
- Store data on third-party servers (except temporary processing)

## Data Security

### Local Security

- **Encryption**: AES-GCM encryption for all sensitive data
- **Key Management**: Encryption keys stored in iOS Keychain (hardware-backed security)
- **File Protection**: iOS File Protection API ensures data is encrypted at rest
- **No Cloud Sync**: All data remains on your device

### Network Security

- **HTTPS**: All API communications use TLS 1.2+ encryption
- **Authentication**: JWT tokens for secure API access
- **Rate Limiting**: Server-side rate limiting prevents abuse

## Your Rights and Choices

### Access and Deletion

- **View Data**: All data is stored locally and accessible through the app
- **Delete Data**: You can delete all data at any time through app settings
- **Export Data**: Contact us to request data export (we can provide anonymized exports)

### Opt-Out

- You can stop using analysis features at any time
- Disabling analysis features prevents any data from being sent to our servers

## Children's Privacy

This app is designed for parents to track their children's development. We take extra precautions for children's data:

- **COPPA Compliance**: We comply with the Children's Online Privacy Protection Act (COPPA)
- **Minimal Data Collection**: We collect only what's necessary for the app's functionality
- **No Direct Collection**: We do not collect data directly from children
- **Parental Control**: All data is controlled by parents

## Data Retention

- **Local Data**: Stored on your device until you delete it
- **Server Data**: Analysis requests are processed and immediately discarded (no permanent storage)
- **Backups**: If you use iCloud backup, your encrypted data may be included in backups

## International Data Transfers

Our backend services may process data in various countries. All data transfers comply with applicable data protection laws, and we ensure appropriate safeguards are in place.

## Changes to This Privacy Policy

We may update this Privacy Policy from time to time. We will notify you of any changes by:

- Posting the new Privacy Policy in the app
- Updating the "Last Updated" date
- Requiring acceptance of the new policy on next app launch (for material changes)

## Contact Us

If you have questions about this Privacy Policy or our data practices, please contact us at:

- **Email**: [Your Support Email]
- **GitHub**: [Your GitHub Repository]

## Compliance

This Privacy Policy complies with:

- **GDPR** (General Data Protection Regulation)
- **COPPA** (Children's Online Privacy Protection Act)
- **CCPA** (California Consumer Privacy Act)
- **Apple App Store Guidelines**

---

**Important**: By using PatternWise, you acknowledge that you have read and understood this Privacy Policy and agree to its terms.

